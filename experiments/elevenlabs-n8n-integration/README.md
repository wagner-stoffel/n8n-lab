# Voice Workflows — ElevenLabs + n8n

**Status:** Both integration patterns implemented and tested; the voice portfolio assistant was published and tested through its shareable link.  
**Stack:** n8n · ElevenLabs · Google Gemini · Google Sheets

I implemented two voice workflows: an audio request-and-response pipeline orchestrated by n8n, and an ElevenLabs conversational agent that calls an n8n portfolio-query workflow.

## n8n-orchestrated audio

Browser recording → POST Webhook → ElevenLabs speech-to-text → AI Agent with Gemini → ElevenLabs text-to-speech → Respond to Webhook → browser audio playback.

I first connected a chat trigger and Gemini agent to the ElevenLabs text-to-speech node. I mapped the agent's output into the text field, generated audio with Miss Walker and Jason, and downloaded and played the resulting files.

I then replaced the chat input with a POST webhook and added speech-to-text. I used a local HTML page to record audio, send it to the webhook and play the returned audio.

| Setting | Configuration I used |
| --- | --- |
| Webhook method | POST |
| Webhook response mode | Using Respond to Webhook node |
| Speech-to-text binary input | `audio` |
| AI Agent prompt source | Define below |
| AI Agent prompt expression | `{{ $json.text }}` |
| Text-to-speech input | `{{ $json.output }}` |
| Webhook response | Binary audio file from the text-to-speech output (`data`) |

I inspected failed executions and corrected the binary input name from `data` to `audio`. I also replaced the agent's chat-trigger input with the transcription's `text` field.

The completed round trip answered the recorded question “What is two plus two?” with spoken audio stating that the answer is four.

## ElevenLabs-orchestrated portfolio assistant

Spoken question → ElevenLabs agent → webhook tool → n8n POST Webhook → AI Agent with Gemini and Google Sheets tool → Respond to Webhook → ElevenLabs spoken answer.

I configured a Gemini chat model in n8n and a Google Sheets tool that retrieves portfolio holdings. I set a manual tool description explaining its role in answering holdings questions.

I tested the lookup with a temporary chat trigger and Simple Memory. The agent returned two shares of SPY. I then removed the temporary chat trigger and memory and used the webhook as the workflow input.

### Voice-agent tool

I created an ElevenLabs agent with the Russell voice and added a webhook tool for portfolio questions.

| Setting | Configuration |
| --- | --- |
| HTTP method | POST |
| Request body field | `question`, type string |
| Field description | Specific portfolio question for the specialist to answer |
| Tool timeout | 60 seconds |
| Pre-tool speech | Enabled to acknowledge the lookup before execution |
| n8n prompt | `{{ $json.body.question }}` |
| Response node | First incoming item, returning the agent result as JSON |

The payload below illustrates the request shape used in the integration:

```json
{
  "question": "How many shares of SPY do I have in my portfolio?"
}
```

The initial voice call reached n8n but failed because the agent still expected chat-trigger input. I inspected the webhook payload, mapped `body.question` into the prompt and reran the conversation successfully.

## Publication and execution

I published the n8n workflow, replaced the tool's test URL with its production webhook URL and saved the configuration. I also published the ElevenLabs agent and opened its shareable link.

In the published conversation, I asked how many SPY shares were held and received the answer “two.” I then asked about the other holdings and received a spoken listing from the portfolio lookup.

The shareable-link test exercised consecutive questions through the published integration. The [execution record](validation.md) documents the audio pipeline, troubleshooting and portfolio queries.

[Portfolio case study](https://github.com/wagner-stoffel/portfolio/tree/main/projects/04-voice-portfolio-assistant) · [Back to lab](../../README.md)
