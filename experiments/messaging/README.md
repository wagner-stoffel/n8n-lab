# Messaging and notifications

I built three integrations to explore how an AI workflow can communicate outside the n8n chat: a push notification with Pushover, a conversation through Telegram, and a bot responding to mentions in Slack.

I am interested in the whole path: receiving an event, finding the useful data, passing it to the agent and delivering the response to the right destination.

## Pushover — reaching my phone

**Flow:** Chat Trigger → AI Agent, with a chat model, memory, Pushover tool and current-date tool.

I used Pushover to send notifications requested in chat. The agent supplies the message, while the date tool gives it current-date information when needed.

The distinction I keep in my notes is between the application API token and the user key. Both need care when sharing a workflow, including values stored in ordinary node fields.

**Next:** I want to add a reviewed export and pair a notification screenshot with its execution record.

## Telegram — a conversation outside the editor

**Flow:** Telegram Trigger → AI Agent → Telegram Send Message, with a chat model, Simple Memory and current-date tool.

I connected a bot created through BotFather. I mapped the incoming message text to the agent prompt, used the agent output as the reply, and retrieved the destination chat ID from the trigger.

I used that chat ID as the memory session key. This gives me a useful starting point for conversation context. In a group, chat-level memory is shared; I still want to explore when a separate user or thread boundary makes more sense.

My [expression notes](../../docs/data-and-expressions.md) capture the field mappings. I still need to record exact versions and settings alongside the export.

**Next:** I want to document a request/reply pair, a memory exchange and an execution after publishing, then check behavior across separate chats and messages without text.

## Slack — responding to mentions

**Flow:** Slack Trigger on app mention → AI Agent → Slack Send Message, with a chat model and current-date tool.

I set up an app, invited the bot to a channel and connected mention events to the trigger webhook. The agent output becomes the outgoing message. I explored the difference between a test webhook and a production webhook using a fixed test channel.

I used a bot OAuth token in the n8n credential. I distinguish that token setup from implementing a complete OAuth authorization-code flow.

I also explored serializing incoming JSON for the prompt. Next, I want to compare that approach with passing only the fields the agent needs.

For a reusable deployment, I want to verify request signing and record how failures are handled. My references are the [n8n credential documentation](https://docs.n8n.io/integrations/builtin/credentials/slack/) and [Slack request verification](https://docs.slack.dev/authentication/verifying-requests-from-slack/).

**Next:** I want to add a redacted mention/reply pair, webhook verification and execution details.

## My working notes

I have implemented these integrations, including publication experiments. I have not yet added the workflow exports or detailed execution records to this repository, and I am not treating the experiments as continuously operated services.

My [validation notebook](validation.md) tracks the results I still need to record and the additional checks I want to run.

## Questions I want to explore next

- Can I use Telegram as an interface for the Equity EOD AI Agent?
- How should I report a successful or partially failed spreadsheet update through Pushover?
- What business task would make the Slack integration useful beyond a general conversation?
- How should I handle repeated events and isolate conversation context?

[Back to lab](../../README.md)
