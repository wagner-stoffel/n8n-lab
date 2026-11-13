# Messaging — implementation record

I implemented Pushover, Telegram and Slack integrations in n8n, including workflow publication tests.

| Integration | What I implemented |
| --- | --- |
| Pushover | Connected a notification tool to the agent, with model-defined message content and a current-date tool |
| Telegram | Connected the bot trigger to the agent and mapped its answer to Send Message |
| Telegram destination | Retrieved the originating chat ID from the trigger |
| Telegram memory | Used the chat ID as the Simple Memory session key |
| Slack | Connected app-mention events to the trigger webhook and sent the agent response to the configured channel |
| Slack credentials | Configured the bot OAuth token in n8n |
| Data mapping | Used JSON expressions to pass inputs, retrieve earlier-node fields and format agent messages |
| Publication | Tested publication and the distinction between test and production webhooks |

[Back to messaging integrations](README.md)
