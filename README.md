# n8n Lab — Wagner Stoffel

I use this lab to explore what I can build with n8n, AI agents and connected services. I try integrations, inspect how data moves between nodes, and keep notes on what works and what I want to investigate next.

My [portfolio](https://github.com/wagner-stoffel/portfolio) brings together selected cases and their business context. Here, I keep the experiments and technical notes.

## What I am exploring

| Area | My focus | Where I am |
| --- | --- | --- |
| [Messaging and notifications](experiments/messaging/README.md) | Pushover, Telegram, Slack, webhooks and conversational memory | I have built the three integrations; exports and execution records are next |
| [Data and expressions](docs/data-and-expressions.md) | JSON, field mapping and references between nodes | My working notes and examples |
| [Validation](experiments/messaging/validation.md) | Delivery, context, failures and repeatability | My checklist for recording results |

## Inside the lab

- [Messaging experiments](experiments/messaging/README.md)
- [JSON and expressions](docs/data-and-expressions.md)
- [Validation notebook](experiments/messaging/validation.md)
- [How I prepare workflows for sharing](docs/publishing-workflows.md)

I have implemented the messaging workflows in n8n. I still need to add their reviewed exports, screenshots and execution details here. For now, these pages are my field notes rather than ready-to-import workflows.

## Where I want to take this

I want to try Telegram as an interface for my Equity EOD AI Agent, explore completion alerts for spreadsheet updates, and give the Slack integration a concrete business task. Those connections are still on my backlog.

I keep small experiments together here. When one develops a clear purpose, reusable setup and recorded validation, I can give it its own repository and feature it in my portfolio.

Related explorations: [Equity EOD AI Agent](https://github.com/wagner-stoffel/portfolio/tree/main/projects/01-equity-eod-ai-agent) and [Gmail Draft Assistant](https://github.com/wagner-stoffel/portfolio/tree/main/projects/02-gmail-draft-assistant).
