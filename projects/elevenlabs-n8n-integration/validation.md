# Voice Workflows — execution record

I tested the audio pipeline and the conversational portfolio integration.

| Execution | Observed result | Configuration adjustment |
| --- | --- | --- |
| Chat response to speech | Generated audio files played with Miss Walker and Jason voices | Mapped agent output to the text-to-speech input |
| Initial browser audio submission | Speech-to-text failed while looking for the wrong binary property | Changed input property from `data` to `audio` |
| Transcription to AI Agent | Transcription was available; the agent still expected chat-trigger input | Selected Define below and mapped `{{ $json.text }}` |
| Completed browser round trip | Recorded arithmetic question returned spoken audio answering four | Returned the generated binary audio through Respond to Webhook |
| Portfolio lookup through temporary chat | Agent returned two SPY shares | Connected Gemini and the Google Sheets holdings tool |
| First ElevenLabs webhook call | The request reached n8n, but the agent input mapping failed | Mapped `{{ $json.body.question }}` |
| Repeated Preview query | Voice agent answered that the portfolio held two SPY shares | Used the corrected webhook input mapping |
| Published shareable-link conversation | Agent answered the SPY question and a follow-up about other holdings | Published both sides and saved the production webhook URL in the tool |

The holdings described here are outputs from the configured portfolio used in these executions.

[Back to implementation](README.md)
