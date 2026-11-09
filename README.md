# n8n Lab — Wagner Stoffel

I build and test workflow automations with n8n, AI agents and connected services. This repository documents the integrations I implemented, their configuration and execution results. My [portfolio](https://github.com/wagner-stoffel/portfolio) presents the business context of selected projects.

## Implemented workflows

| Workflow | Integrations | Implementation |
| --- | --- | --- |
| [Portfolio rebalancer](experiments/portfolio-rebalancer/README.md) | Google Sheets, Marketstack, Gmail and Pushover | Form input, EOD price updates, proposed quantities, allocation checks and conditional notifications |
| [Messaging and notifications](experiments/messaging/README.md) | Pushover, Telegram and Slack | Push notifications, conversational replies and responses to app mentions |
| [Voice customer support](experiments/elevenlabs-voice-agent/README.md) | ElevenLabs | Voice agents, product and stock knowledge documents, conditional routing and spoken tests |
| [Data mapping](docs/data-and-expressions.md) | JSON and n8n expressions | Prompt input, agent output, reply destination and memory session mapping |

## Portfolio automation

I implemented a form-driven workflow that reads a portfolio, retrieves EOD prices, updates proposed holdings, rereads the allocation and communicates the result. I configured the agent instructions, tool descriptions and conditional notification routing.

I tested successful and unsuccessful versions, inspected execution details and published the workflow. The [implementation documentation](experiments/portfolio-rebalancer/README.md) describes the components and execution behavior.

## Voice customer support

I built and tested a voice-support workflow in ElevenLabs with a main agent and separate product and stock specialists. I configured prompts, voices, knowledge documents and routing conditions, then tested both routes in spoken conversations.

## Technical documentation

- [Voice-agent implementation](experiments/elevenlabs-voice-agent/README.md)
- [Voice-agent execution record](experiments/elevenlabs-voice-agent/validation.md)
- [Messaging integrations](experiments/messaging/README.md)
- [Messaging implementation record](experiments/messaging/validation.md)
- [JSON and expressions](docs/data-and-expressions.md)
- [Workflow publication](docs/publishing-workflows.md)

Related case: [Equity EOD AI Agent & Portfolio Rebalancer](https://github.com/wagner-stoffel/portfolio/tree/main/projects/01-equity-eod-ai-agent).
