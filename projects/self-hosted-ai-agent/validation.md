# Self-Hosted AI Agent — Execution Record

I tested a conversational agent in a local n8n Docker instance with Simple Memory and a Marketstack tool. I used OpenRouter for remote inference and then replaced that model connection with Ollama on the host computer.

| Test | Observed result |
| --- | --- |
| Local n8n startup | The Docker container started and the editor opened at `http://localhost:5678`; I configured the local owner account. |
| OpenRouter credential | The connection test succeeded. |
| DeepSeek V3.2 greeting | The agent returned a conversational response. |
| DeepSeek first Apple-price request | The response contained function-invocation text, but Marketstack was not called. |
| DeepSeek repeated Apple-price request | Marketstack was called and the agent returned price information. |
| GPT-OSS 120B through OpenRouter | The agent called Marketstack and returned an Apple closing price of USD 270. |
| Container restart for Ollama | I reopened the saved workflow after restarting n8n with the host mapping. |
| Ollama credential | The connection test succeeded and downloaded local models appeared in the model selector. |
| Ollama-backed greeting | The agent returned a conversational response using local inference. |
| Ollama-backed Apple-price request | Marketstack was called and the agent returned an Apple closing price of USD 270. |

## Interpretation

The DeepSeek runs show why I inspected the actual tool execution as well as the final answer: function-invocation text alone did not represent a completed data lookup. The repeated prompt triggered a successful call.

The USD 270 values record the answers returned in those executions. They are historical test outputs, not live market quotes or independently verified prices.

For the Ollama configuration, n8n and model inference ran locally, while the Marketstack tool retrieved data from an external service.

[Implementation](README.md) · [Back to lab](../../README.md)
