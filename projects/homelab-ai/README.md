# HomeLab AI — Wagner Stoffel

Docker configuration and operating guides for a dedicated n8n automation server with local Ollama inference, NVIDIA GPU access, persistent storage and Google integrations.

## Reference hardware

| Component | Configuration |
| --- | --- |
| CPU | AMD Ryzen 7 5700X, 8 cores / 16 threads |
| RAM | 32 GB DDR4 |
| GPU | NVIDIA GeForce RTX 3060, 12 GB VRAM |
| Storage | 1 TB NVMe SSD |
| Backup destination | Separate 1 TB external drive |
| Network | Gigabit Ethernet |
| OS | Ubuntu Server 24.04 LTS |
| Administration | Windows notebook with SSH |

This sizing targets a single-user automation lab and one local model request at a time. Context length, workflow concurrency and model size affect resource use.

## Architecture

```text
Windows notebook ── SSH forwarding ── n8n editor
External caller ── ngrok HTTPS ────── n8n webhook
                                      │
                         ┌────────────┼─────────────┐
                         ▼            ▼             ▼
                       Ollama     Google APIs   Marketstack
                         │
                    NVIDIA GPU
                         │
                     Qwen3 8B
```

n8n and Ollama share a Docker network. The agent uses `http://ollama:11434`; Ollama has no published host port. n8n is bound to host loopback. ngrok runs on the Ubuntu host when public access is required.

## Configuration

- n8n with persistent SQLite storage and São Paulo timezone.
- Ollama with one NVIDIA GPU, one loaded model and one parallel request.
- Initial context of 4,096 tokens for short conversations and tool tests.
- Separate volumes for credentials/workflows and model files.
- An optional Compose override for a public HTTPS tunnel.
- Service restart policy: `unless-stopped`.

The n8n image is pinned in `.env.example`. Ollama's image reference is configurable; record the resolved image digest when reproducing a deployment.

## Guides

From the root of a cloned n8n-lab repository, enter the project directory before running its commands:

```bash
cd projects/homelab-ai
```

1. [Install and start the server](docs/installation.md)
2. [Configure the agent, webhooks and Google OAuth](docs/integrations.md)
3. [Validate behavior](docs/validation.md)
4. [Back up and restore](docs/backup-and-restore.md)

Commands in the guides run in Ubuntu Bash unless explicitly labeled Windows PowerShell. Use the project directory as the working directory.

## Files

```text
homelab-ai/
├── README.md
├── .env.example
├── .gitignore
├── compose.yaml
├── compose.public.yaml
└── docs/
    ├── installation.md
    ├── integrations.md
    ├── validation.md
    └── backup-and-restore.md
```

## References

- [Ollama hardware support](https://docs.ollama.com/gpu)
- [Qwen3 8B model](https://ollama.com/library/qwen3:8b)
- [Docker Compose GPU configuration](https://docs.docker.com/compose/how-tos/gpu-support/)
- [Ollama context configuration](https://docs.ollama.com/context-length)
- [n8n Docker installation](https://docs.n8n.io/hosting/installation/docker/)
- [Related local integrations](https://github.com/wagner-stoffel/n8n-lab/tree/main/projects/n8n-local-integrations)

