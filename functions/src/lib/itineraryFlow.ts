import { noAuth, onFlow } from "@genkit-ai/firebase/functions";
import { Activity, Destination, ItineraryFlowInput, ItineraryFlowOutput, Place } from "./types";
import { retrieve } from "@genkit-ai/ai";
import { getActivitiesForDestination, placesRetriever } from "./placesRetriever";
import { prompt } from '@genkit-ai/dotprompt';
import { run } from "@genkit-ai/flow";



export interface ItineraryGeneratorPromptInput {
    request: string;
    place: string;
    placeDescription: string;
    activities: Activity[];
}

const generateItinerary = async (request: string, place: Place) => {
    const activities = await getActivitiesForDestination(place.ref);

    const itineraryGenerator =
        await prompt<ItineraryGeneratorPromptInput>('itineraryGen');
    const response = await itineraryGenerator.generate({
        input: {
            request: request,
            place: place.name,
            placeDescription: place.knownFor,
            activities,
        },
    });

    const destination = response.output() as Destination;
    destination.itineraryImageUrl = place.imageUrl;
    destination.placeRef = place.ref;
    return destination;
};



export const itineraryFlow = onFlow(
    {
        name: 'itineraryFlow',
        inputSchema: ItineraryFlowInput,
        outputSchema: ItineraryFlowOutput,
        authPolicy: noAuth(),

    },

    async (tripDetails) => {

        const imgDescription = await run('imgDescription', async () => {
            if (!tripDetails.imageUrls?.length) {
                return '';
            }
            const imgDescription = await prompt('imgDescription');
            const result = await imgDescription.generate({
                input: { imageUrls: tripDetails.imageUrls },
            });
            return result.text();
        });

        const places = await run(
            'Retrieve matching places',
            { imgDescription, request: tripDetails.request },
            async () => {
                const docs = await retrieve({
                    retriever: placesRetriever,
                    query: `${tripDetails.request}\n${imgDescription}`,
                    options: {
                        limit: 3,
                    },
                });
                return docs.map((doc) => {
                    const data = doc.toJSON();
                    const place = data.metadata as Place;
                    if (data.content[0].text) {
                        place.knownFor = data.content[0].text;
                    }
                    delete place.embedding;
                    return place;
                });
            },
        );

        const itineraries = await Promise.all(
            places.map((place, i) =>
                run(`Generate itinerary #${i + 1}`, () =>
                    generateItinerary(tripDetails.request, place),
                ),
            ),
        );
        return itineraries;
    },
);
