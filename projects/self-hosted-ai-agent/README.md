# Self-Hosted AI Agent with Docker and Ollama

**Status:** Implemented and tested.  
**Stack:** n8n · Docker · Ollama · OpenRouter · Marketstack · Simple Memory

I deployed n8n locally in Docker, built a conversational price assistant and tested it with remote models through OpenRouter. I then connected the same agent to Ollama running on the host computer and tested a stock-price query with local inference.

## Implemented architecture

| Component | Configuration |
| --- | --- |
| n8n | Docker container named `n8n`, accessed at `http://localhost:5678` |
| Persistent storage | Named volume `n8n_data` mounted at `/home/node/.n8n` |
| Conversation | Chat Trigger → AI Agent, connected to Simple Memory |
| Remote inference | OpenRouter Chat Model with DeepSeek V3.2 and GPT-OSS 120B |
| Local inference | Ollama Chat Model connected to the host at `http://host.docker.internal:11434` |
| Financial data | Marketstack tool with model-selected ticker and the Latest filter enabled |

The OpenRouter configuration runs orchestration locally and inference remotely. The Ollama configuration runs both orchestration and inference locally. Marketstack remains an external API in both configurations.

## Docker configuration

I configured the container port, persistent volume, timezone environment variables and settings-file permissions, then created the local owner account in the n8n editor.

The following startup command includes the host mapping used for Ollama, with the timezone adapted to São Paulo:

```powershell
docker run -it --rm --name n8n -p 5678:5678 --add-host=host.docker.internal:host-gateway -e GENERIC_TIMEZONE="America/Sao_Paulo" -e TZ="America/Sao_Paulo" -e N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n
```

- `5678:5678` maps the editor's container port to the host.
- `GENERIC_TIMEZONE` configures schedule-oriented nodes; `TZ` sets the container timezone.
- `n8n_data` stores n8n data separately from the disposable container.
- `host.docker.internal:host-gateway` provides a hostname for reaching services on the host.
- Ctrl+C stops the foreground process. The `--rm` option removes the stopped container while preserving the named volume.

The startup example uses the n8n 2.x configuration: the earlier `N8N_RUNNERS_ENABLED=true` setting is no longer required.

## Agent configuration

I connected the chat trigger to an AI Agent, added Simple Memory and configured the OpenRouter credential. I tested DeepSeek V3.2, then switched to GPT-OSS 120B through OpenRouter.

I added Marketstack as an agent tool, supplied its API credential, enabled model selection of the ticker and turned on the Latest filter. I inspected whether the tool was actually called when asking for Apple's stock price.

## Ollama connection

I installed Ollama on the host and downloaded local models. After stopping n8n, I restarted its container with the host mapping and reopened the saved workflow.

I replaced the OpenRouter Chat Model with an Ollama Chat Model and set its credential Base URL to:

```text
http://host.docker.internal:11434
```

The connection test succeeded and the node listed the locally downloaded models. I selected a local model, tested a greeting and then asked for Apple's share price. The agent called Marketstack and returned a closing-price answer.

Inside the n8n container, `localhost` refers to the container itself. The host address connects the container to Ollama running on the computer.

## Execution results

I tested chat responses and financial-data tool calls in both configurations. With DeepSeek, the first price request returned function-invocation text without calling Marketstack; repeating the request triggered the tool. GPT-OSS through OpenRouter and the Ollama-backed agent both called Marketstack successfully in the recorded price queries.

The [execution record](validation.md) details these outcomes.

## References

- [n8n Docker configuration](https://docs.n8n.io/hosting/installation/docker/)
- [n8n Ollama credentials](https://docs.n8n.io/integrations/builtin/credentials/ollama/)
- [Docker host mapping](https://docs.docker.com/reference/cli/docker/container/run/#add-entries-to-container-hosts-file---add-host)
- [Ollama](https://ollama.com)

[Equity EOD case study](https://github.com/wagner-stoffel/portfolio/tree/main/projects/01-equity-eod-ai-agent) · [Back to lab](../../README.md)
