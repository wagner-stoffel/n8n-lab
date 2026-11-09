# Voice Customer Support — execution record

I tested the agents through ElevenLabs Preview using spoken conversations.

| Configuration tested | Action | Observed behavior |
| --- | --- | --- |
| Initial voice agent | Asked for a fun fact and a joke | The agent responded by voice within the conversation |
| Airline assistant | Asked about a return trip from New York to London | The agent used the ticket price supplied in its system prompt |
| Product knowledge | Asked about Apple Watch models and pricing | The agent answered using the configured product context |
| Product-support route | Asked the main agent about the latest Apple Watch | The conversation transferred to the product specialist, which answered the original question |
| Stock route | Asked which MacBook Pro models the store had in stock | The stock specialist answered MacBook Pro M4, matching the stock document |
| Conversation ending | Closed the product conversation | The conversation terminated |

Product names, prices and availability in these interactions describe the configured example data and the responses observed during testing.

[Back to implementation](README.md)
