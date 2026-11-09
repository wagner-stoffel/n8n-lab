# Voice Customer Support — ElevenLabs

**Status:** Implemented and tested.  
**Platform:** ElevenLabs Agents Platform

I built voice agents and a customer-support workflow that routes questions to product and stock specialists. I configured system prompts, first messages, voices and document-based knowledge.

## Voice-agent configuration

I created a blank voice agent, selected its language, voice and language model, and tested it in Preview. I changed the system prompt and voice to test different roles, including an airline assistant using a ticket price supplied in its prompt.

I added a product-information document to the knowledge base and tested an Apple Watch question. The agent answered with product information from the configured context.

## Customer-support workflow

Incoming conversation → Main agent → Product support or Stock specialist.

| Agent | Configuration |
| --- | --- |
| Main agent | Customer-support prompt that directs the user's question; Miss Walker voice; no inherited knowledge base |
| Product support | Prompt for general Apple product questions; Russell voice; product-details document |
| Stock specialist | Prompt for store availability questions; Stokes voice; stock document |

I enabled prompt overrides for each role and assigned the specialists their respective documents instead of inheriting the shared knowledge base.

The stock document contained Apple Watch Series 11, iPhone 13 Pro Max and MacBook Pro M4. These were the configured store-example entries.

## Routing

- General Apple product questions transfer to Product support.
- Questions about products available in the store transfer to the Stock specialist.

I configured the two outgoing conditions from the main agent. The receiving specialist answered the question carried through the transfer.

## Execution results

I ran separate Preview conversations for the two routes:

| Input | Observed result |
| --- | --- |
| Question about the latest Apple Watch model | The product route answered with Apple Watch models from the configured product context |
| Question about MacBook Pro models in stock | The stock route answered that MacBook Pro M4 was available |

The product conversation ended after the closing exchange. The [execution record](validation.md) describes the tested behavior.

[Portfolio case study](https://github.com/wagner-stoffel/portfolio/tree/main/projects/03-voice-customer-support) · [Back to lab](../../README.md)
