# Week 1 · Day 4 — Communication integrations

**Status:** All lesson examples completed by the author, as confirmed on November 5, 2026.  
**Evidence:** Workflow exports and execution records are not yet included. The notes below describe the exercise architecture from the supplied lesson; exact settings in the author's instance still need to be recorded.

## What I practiced

- Reading JSON objects, arrays and nested values.
- Mapping incoming data and agent output with expressions.
- Referencing earlier nodes to recover conversation identifiers.
- Connecting services through credentials and event webhooks.
- Sending notifications and building two-way messaging workflows.
- Configuring conversational memory and publishing workflows.

## 1. Pushover — outbound notifications

**Exercise flow:** Chat Trigger → AI Agent, with a chat model, memory, Pushover tool and current-date tool.

The Pushover tool sends a notification requested in chat. The exercise distinguishes the application API token from the user key and lets the model supply the notification message. A current-date tool supplies the date for the notification exercise.

**Configuration notes:** Keep the application token in n8n credentials. Treat the user key as private even if it appears in a normal node field; remove it from shared exports. Identify keys by their purpose, not a presumed first character.

**Evidence to add:** Sanitized workflow, notification receipt and corresponding execution record.

## 2. Telegram — two-way AI conversation

**Exercise flow:** Telegram Trigger → AI Agent → Telegram Send Message. The agent has a chat model, Simple Memory and a current-date tool.

The bot token comes from BotFather. Incoming message text supplies the agent prompt; the agent output supplies the reply. The destination chat ID comes from the trigger, so the reply returns to the original conversation. The lesson uses the chat ID as the memory session key.

See the [expression examples](../../docs/data-and-expressions.md) for the input/output mappings.

**Configuration notes:** These examples assume text messages and the node names in the lesson. Inspect actual incoming data before mapping fields. Chat-level memory is shared within a group chat; it must not be described as private per-user memory. Exact node/model versions and memory settings are pending documentation.

**Evidence to add:** A redacted request/reply pair, a same-chat memory exchange and an execution after publishing. Current deployment status is not recorded.

## 3. Slack — mentions, webhooks and replies

**Exercise flow:** Slack Trigger on app mention → AI Agent → Slack Send Message, with a chat model and current-date tool.

The lesson creates a Slack app, installs it in a workspace, subscribes to app mentions, invites the bot to a channel and configures the trigger's webhook URL. The outgoing message uses the agent output. The lesson starts with a fixed test-channel ID and distinguishes test and production webhook URLs.

The lesson places a bot OAuth token in the n8n credential. That is distinct from demonstrating a complete OAuth authorization-code flow inside n8n. The exact credential type used in the author's instance should be recorded with its export.

The course also demonstrates serializing the incoming JSON into the prompt. A future version can pass only the fields needed for the task. Incoming message content remains user data and must not override workflow rules.

**Configuration notes:** Configure and validate the Slack signing secret when preparing a reusable deployment. The instructor's troubleshooting decision to omit it is not a security recommendation. See [n8n Slack credentials](https://docs.n8n.io/integrations/builtin/credentials/slack/) and [Slack request verification](https://docs.slack.dev/authentication/verifying-requests-from-slack/).

**Evidence to add:** Redacted app-mention/reply pair, webhook verification and execution record. No workspace identifiers or tokens should be published.

## Publication and validation

The lesson includes publishing workflows, using a production webhook for Slack and inspecting executions. Completing the exercise does not establish that the workflows remain active today.

The [validation record](validation.md) separates the author's completion confirmation from checks whose individual results have not been supplied. Additional failure and isolation checks are proposed, not retrospectively marked as passed.

## Possible extensions

- Use Telegram as a channel for the Equity EOD AI Agent.
- Notify completion or partial failure of a Sheets update through Pushover.
- Adapt the Slack exercise to a defined business task.

These extensions have not been claimed as implemented.

[Back to lab](../../README.md)
