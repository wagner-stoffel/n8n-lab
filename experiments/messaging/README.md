# Messaging and notifications

I built three integrations that connect AI workflows to messaging services: a push notification with Pushover, a conversation through Telegram, and a bot responding to mentions in Slack.

I configured event reception, input mapping, agent execution and delivery to the destination.

## Pushover — reaching my phone

**Flow:** Chat Trigger → AI Agent, with a chat model, memory, Pushover tool and current-date tool.

I used Pushover to send notifications requested in chat. The agent supplies the message, while the date tool gives it current-date information when needed.

The distinction I keep in my notes is between the application API token and the user key. Both need care when sharing a workflow, including values stored in ordinary node fields.

## Telegram — a conversation outside the editor

**Flow:** Telegram Trigger → AI Agent → Telegram Send Message, with a chat model, Simple Memory and current-date tool.

I connected a bot created through BotFather. I mapped the incoming message text to the agent prompt, used the agent output as the reply, and retrieved the destination chat ID from the trigger.

I used that chat ID as the memory session key. This associates conversation context with the chat. In a group, chat-level memory is shared.

My [expression notes](../../docs/data-and-expressions.md) capture the field mappings.

## Slack — responding to mentions

**Flow:** Slack Trigger on app mention → AI Agent → Slack Send Message, with a chat model and current-date tool.

I set up an app, invited the bot to a channel and connected mention events to the trigger webhook. The agent output becomes the outgoing message. I configured test and production webhooks using a fixed test channel.

I used a bot OAuth token in the n8n credential. I distinguish that token setup from implementing a complete OAuth authorization-code flow.

I serialized incoming JSON for the agent prompt.

## Implementation record

I implemented the three messaging integrations and tested workflow publication. The [implementation record](validation.md) summarizes the configured components.

[Back to lab](../../README.md)
