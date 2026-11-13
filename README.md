# n8n Lab — Wagner Stoffel

I build and test workflow automations with n8n, AI agents and connected services. This repository documents the integrations I implemented, their configuration and execution results. My [portfolio](https://github.com/wagner-stoffel/portfolio) presents the business context of selected projects.

## Implemented workflows

| Workflow | Integrations | Implementation |
| --- | --- | --- |
| [Product knowledge ingestion](experiments/product-knowledge-ingestion/README.md) | Google Sheets, Supabase and OpenAI embeddings | Product transformation, category metadata, 1536-dimensional embeddings and 60-document ingestion |
| [Voice workflows and portfolio assistant](experiments/elevenlabs-n8n-integration/README.md) | ElevenLabs, Gemini and Google Sheets | Audio round trip, POST webhook tool, holdings lookup and published voice conversation |
| [Voice customer support](experiments/elevenlabs-voice-agent/README.md) | ElevenLabs | Voice agents, product and stock knowledge documents, conditional routing and spoken tests |
| [Portfolio rebalancer](experiments/portfolio-rebalancer/README.md) | Google Sheets, Marketstack, Gmail and Pushover | Form input, EOD price updates, proposed quantities, allocation checks and conditional notifications |
| [Messaging and notifications](experiments/messaging/README.md) | Pushover, Telegram and Slack | Push notifications, conversational replies and responses to app mentions |
| [Data mapping](docs/data-and-expressions.md) | JSON and n8n expressions | Prompt input, agent output, reply destination and memory session mapping |

## Product knowledge ingestion

I transformed 60 product rows into readable documents, generated embeddings and loaded them into Supabase. I inspected the stored content and metadata, corrected a formatting error and reloaded the 60 documents.

## Retrieval analysis and database setup

I analyzed retrieval-augmented generation, embeddings, semantic search and agent-directed retrieval. I also set up a personal Supabase account and reviewed its database offering, documentation and plans.

- [Retrieval and agentic RAG analysis](docs/retrieval-and-agentic-rag.md)
- [Supabase account setup and platform review](docs/supabase-setup.md)

## Voice and n8n integration

I implemented an audio pipeline with transcription, Gemini responses and speech generation. I also connected an ElevenLabs voice agent to an n8n Google Sheets lookup through a POST webhook, published the integration and tested consecutive portfolio questions.

## Voice customer support

I built and tested a voice-support workflow in ElevenLabs with a main agent and separate product and stock specialists. I configured prompts, voices, knowledge documents and routing conditions, then tested both routes in spoken conversations.

## Portfolio automation

I implemented a form-driven workflow that reads a portfolio, retrieves EOD prices, updates proposed holdings, rereads the allocation and communicates the result. I configured the agent instructions, tool descriptions and conditional notification routing.

I tested successful and unsuccessful versions, inspected execution details and published the workflow. The [implementation documentation](experiments/portfolio-rebalancer/README.md) describes the components and execution behavior.

## Technical documentation

- [Product ingestion implementation](experiments/product-knowledge-ingestion/README.md)
- [Database schema](experiments/product-knowledge-ingestion/schema.sql)
- [Ingestion execution record](experiments/product-knowledge-ingestion/validation.md)

- [Voice and n8n integration](experiments/elevenlabs-n8n-integration/README.md)
- [Integration execution record](experiments/elevenlabs-n8n-integration/validation.md)
- [Voice-agent implementation](experiments/elevenlabs-voice-agent/README.md)
- [Voice-agent execution record](experiments/elevenlabs-voice-agent/validation.md)
- [Messaging integrations](experiments/messaging/README.md)
- [Messaging implementation record](experiments/messaging/validation.md)
- [JSON and expressions](docs/data-and-expressions.md)
- [Workflow publication](docs/publishing-workflows.md)

Related case: [Equity EOD AI Agent & Portfolio Rebalancer](https://github.com/wagner-stoffel/portfolio/tree/main/projects/01-equity-eod-ai-agent).
