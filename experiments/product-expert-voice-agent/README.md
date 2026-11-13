# Product Expert Voice Agent — Agentic RAG

**Status:** Implemented, tested and published.  
**Stack:** n8n · Supabase · Google Gemini · OpenAI embeddings · ElevenLabs

I built a product-question workflow that retrieves relevant catalog documents from Supabase and connected it to an ElevenLabs sales agent. The knowledge base contains the 60 product documents loaded by my [ingestion workflow](../product-knowledge-ingestion/README.md).

## Chat-based retrieval

I connected a Chat Trigger to an AI Agent with a Google Gemini chat model and Simple Memory. I added the Supabase Vector Store as an agent tool and described it as the source for information about the store's products.

| Setting | Configuration |
| --- | --- |
| Vector-store operation | Retrieve documents as tool for AI Agent |
| Table | knowledgebase |
| Retrieval limit | 10 documents |
| Include metadata | Enabled |
| Query embedding model | text-embedding-3-small |
| Embedding dimensions | 1536 |

The retrieval tool embeds the query with the same model used for the stored product documents. It returns relevant text and metadata to the agent, which uses that context in its answer.

I tested a keyboard question and a question about buying additional computer memory. The agent retrieved product information and returned options with pricing and descriptions.

## Voice workflow

ElevenLabs voice agent → POST webhook → n8n AI Agent → Supabase retrieval tool → agent response → Respond to Webhook → spoken answer.

I replaced the chat trigger with a POST webhook and set the agent's input source to Define below:

```text
{{ $json.body.question }}
```

I configured the webhook to respond through Respond to Webhook. The response contains the agent's JSON result, including its `output` field.

I removed Simple Memory from the webhook backend after using it for chat testing. The backend handles the question supplied by the voice-agent tool on each request.

## ElevenLabs configuration

I created an electronics sales agent with the Miss Walker voice. Its system instructions describe a knowledgeable computer-accessories sales assistant and direct it to use its tool for product questions.

| Tool setting | Configuration |
| --- | --- |
| Purpose | Ask the product expert a question about store products |
| HTTP method | POST |
| Body field | question |
| Field type | Required string, supplied by the model |
| Timeout | 60 seconds |
| Execution | Immediate |
| Pre-tool speech | Forced |
| Interruptions during tool execution | Disabled |
| Tool-call sound | Typing, set to always play |

Request shape:

```json
{
  "question": "What keyboards do you offer?"
}
```

I first connected the tool to the test webhook. In the spoken test, the agent acknowledged the request, retrieved product context and described keyboard options, including gaming, ergonomic and office models.

## Publication

I saved and published the n8n workflow, replaced the tool's test URL with the production webhook URL and saved the tool. I then published the ElevenLabs agent and opened its shareable link.

## Telephone configuration

I worked through Twilio's Programmable Voice and Active Numbers screens, then configured the Twilio import form in ElevenLabs Phone Numbers with a label, phone number, Account SID and Auth Token.

## Execution record

The [execution record](validation.md) captures the chat tests, spoken keyboard response, completed webhook execution and publication steps.

[Portfolio case study](https://github.com/wagner-stoffel/portfolio/tree/main/projects/09-product-expert-voice-agent) · [Back to lab](../../README.md)
