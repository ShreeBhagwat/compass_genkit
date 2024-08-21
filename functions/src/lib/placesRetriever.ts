

import { initializeApp } from 'firebase-admin/app';
import { getFirestore } from 'firebase-admin/firestore';

import { Activity } from './types';
import { getProjectId } from './genkit.config';
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