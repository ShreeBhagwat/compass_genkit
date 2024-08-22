

import { initializeApp } from 'firebase-admin/app';
import { FieldValue, getFirestore } from 'firebase-admin/firestore';

import { Activity, Place } from './types';
import { getProjectId } from './genkit.config';
// import { defineFirestoreRetriever } from '@genkit-ai/firebase';
import { textEmbeddingGecko } from '@genkit-ai/vertexai';
import { embed } from '@genkit-ai/ai/embedder';
import { defineRetriever } from '@genkit-ai/ai/retriever';



const app = initializeApp({
    projectId: getProjectId(),
});
const firestore = getFirestore(app);

/**
 * Returns activities linked with a known `placeId` using Firebase admin sdk for Firestore.
 */
export const getActivitiesForDestination = async (placeId: string) => {
    const docs = await firestore
        .collection('activities')
        .where('destination', '==', placeId)
        .get();
    const resultData = docs.docs.map((doc) => {
        const data = doc.data() as Activity;
        delete data.embedding;
        return data;
    });
    return resultData;
};

/**
 * Returns an embedded text using textEmbeddingGecko.
 */
export const embedGivenText = async (text: string) => {
    const embeddedText = await embed({
        embedder: textEmbeddingGecko, // Embedder is used to embed the data. Make sure it is same as the one used in the retriever.
        content: text,// This can be a text or image.
    });
    return embeddedText;
}

// Gets all the places from firestore and adds the embeddings to the places collection.
export const addEmbeddingstoPlacesFirestore = async (embeddingText: string) => {
    const activities = await firestore.collection('places').get();
    activities.docs.forEach(async (doc) => {
        const place = doc.data() as Place;
        const embeddedText = await embedGivenText(place.knownFor);
        await firestore.collection('places').doc(doc.id).update({
            embedding: FieldValue.vector(embeddedText),
        });
    });
}
/**
 * Retriever for places based on the `knownFor` field using the Genkit retriever for Firestore.
 */
export const placesRetriever = defineRetriever(
    { name: 'placesRetriever' },
    async () => ({ documents: [{ content: [{ text: 'TODO' }] }] }),
);
// TODO: 1. Replace the lines above with this:
// export const placesRetriever = defineFirestoreRetriever({
//     name: 'placesRetriever',
//     firestore,
//     collection: 'places',
//     contentField: 'knownFor',
//     vectorField: 'embedding',
//     embedder: textEmbeddingGecko,
//     distanceMeasure: 'COSINE',
// });