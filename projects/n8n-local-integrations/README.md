# n8n Local Integrations — Wagner Stoffel

**Status:** Implemented and tested.

I configured n8n locally with Docker, exposed webhook endpoints through ngrok and connected Google Sheets and Gmail using custom Google OAuth2 credentials. I tested local workflow execution, public webhook delivery, spreadsheet retrieval and Gmail draft creation.

## Architecture

```text
External request → ngrok HTTPS tunnel → n8n in Docker
Browser → localhost:5678 → n8n editor
n8n → Google OAuth2 → Google Sheets / Gmail
```

The editor and OAuth callback use localhost. ngrok supplies the public webhook address. Docker stores n8n data in a persistent named volume.

## Implemented work

| Area | Implementation | Executed check |
| --- | --- | --- |
| Local environment | Docker and self-hosted n8n | Manual Trigger and Edit Fields returned the configured fields |
| Public webhooks | ngrok tunnel and public webhook URL configuration | POST payload received through test and production webhook URLs |
| Google OAuth2 | Google Cloud project, enabled APIs, consent configuration and web application client | Google credentials authorized in n8n |
| Google Sheets | Authorized spreadsheet access | Test row retrieved |
| Gmail | Authorized draft creation | Draft created and inspected in Gmail |

## Reproduce the setup

From the root of a cloned n8n-lab repository, open PowerShell and enter:

```powershell
cd projects/n8n-local-integrations
```

Follow these guides in order. Commands use Windows PowerShell from this project's directory.

1. [Local installation](docs/01-local-setup.md)
2. [Public webhooks with ngrok](docs/02-webhooks.md)
3. [Google OAuth2, Sheets and Gmail](docs/03-google-oauth.md)
4. [Execution record](docs/validation.md)
5. [Troubleshooting](docs/troubleshooting.md)

The Compose files package the documented configuration for repeatable startup. They use an isolated volume named `n8n_local_integrations_data`; the earlier `n8n_data` volume remains separate. Only one installation can bind host port 5678 at a time.

## Repository structure

```text
n8n-local-integrations/
├── README.md
├── .env.example
├── .gitignore
├── compose.yaml
├── compose.webhooks.yaml
├── docs/
│   ├── 01-local-setup.md
│   ├── 02-webhooks.md
│   ├── 03-google-oauth.md
│   ├── validation.md
│   └── troubleshooting.md
└── scripts/
    └── Send-WebhookTest.ps1
```

## Related implementations

- [Self-hosted AI agent with Docker and Ollama](https://github.com/wagner-stoffel/n8n-lab/tree/main/projects/self-hosted-ai-agent)
- [Professional portfolio](https://github.com/wagner-stoffel/portfolio)

## References

- [n8n Docker configuration](https://docs.n8n.io/hosting/installation/docker/)
- [n8n reverse proxy configuration](https://docs.n8n.io/hosting/configuration/configuration-examples/webhook-url/)
- [Google OAuth2 credentials in n8n](https://docs.n8n.io/integrations/builtin/credentials/google/oauth-single-service/)
- [ngrok setup](https://ngrok.com/docs/start)

