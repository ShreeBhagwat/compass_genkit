import * as z from "zod";

// Import the Genkit core libraries and plugins.
import { generate } from "@genkit-ai/ai";
import { configureGenkit } from "@genkit-ai/core";

import { firebase } from "@genkit-ai/firebase";

// Import models from the Vertex AI plugin. The Vertex AI API provides access to
// several generative models. Here, we import Gemini 1.5 Flash.
import vertexAI, { gemini15Flash } from "@genkit-ai/vertexai";

// From the Firebase plugin, import the functions needed to deploy flows using
// Cloud Functions.
import { noAuth, onFlow } from "@genkit-ai/firebase/functions";
import { dotprompt } from "@genkit-ai/dotprompt";
import { itineraryFlow } from "./lib/itineraryFlow";


configureGenkit({
  plugins: [

    firebase(),

    vertexAI({ location: 'us-central1' }),
    dotprompt({ dir: 'prompts' }),

  ],
  // Log debug output to tbe console.
  logLevel: "debug",

  enableTracingAndMetrics: true,

});


export const menuSuggestionFlow = onFlow(
  {
    name: "menuSuggestionFlow",
    inputSchema: z.string(),
    outputSchema: z.string(),
    authPolicy: noAuth(),
  },
  async (subject) => {
    const prompt =
      `Suggest an item for the menu of a ${subject} themed restaurant`;
    const llmResponse = await generate({
      model: gemini15Flash,
      prompt: prompt,

      config: {
        temperature: 1,
      },
    });

    return llmResponse.text();
  }
);

import './lib/placesRetriever';
export const dreamTripFlow = itineraryFlow;


