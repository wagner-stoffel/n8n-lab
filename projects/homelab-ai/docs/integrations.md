# Agent and external integrations

## Local agent

Create a workflow with Chat Trigger connected to AI Agent. Attach Ollama Chat Model, Simple Memory and Calculator to the agent's respective connections.

Set the Ollama credential Base URL to `http://ollama:11434` and select `qwen3:8b`. The private Ollama endpoint does not require an API key. Configure a 4,096-token context in the model node if it offers an override, matching the server setting.

Use these agent instructions:

```text
Respond in Portuguese. Use Calculator for arithmetic.
Use the configured Marketstack tool for financial-data retrieval.
Only describe tool results after executing the corresponding tool.
```

Add Marketstack as a tool when testing financial retrieval. Configure its credential in n8n, enable model selection of the ticker and use the Latest filter. Local inference and external market-data retrieval are separate operations.

## Public webhooks

Install the ngrok agent on the Ubuntu server following its [setup guide](https://ngrok.com/docs/start). Authenticate using your account's authtoken and run:

```bash
ngrok config add-authtoken YOUR_AUTHTOKEN
ngrok http http://localhost:5680
```

Keep the ngrok process running. In `.env`, set `PUBLIC_BASE_URL` to the actual HTTPS forwarding URL without a trailing slash. In another server terminal:

```bash
sudo docker compose -f compose.yaml -f compose.public.yaml config --quiet
sudo docker compose -f compose.yaml -f compose.public.yaml up -d
```

Use the HTTPS address for the editor during public-mode OAuth authorization. The tunnel forwards the editor as well as webhooks; retain owner authentication. Ollama has no published port and is not the tunnel target.

Create a POST Webhook node with path `homelab-test`, immediate response and no authentication solely for this synthetic test. Listen for a test event and copy the displayed Test URL. From Windows PowerShell:

```powershell
$webhookUrl = 'PASTE_THE_EXACT_TEST_URL'
$payload = @{ project = 'HomeLab AI'; message = 'Webhook connectivity check' } | ConvertTo-Json
Invoke-RestMethod -Method Post -Uri $webhookUrl -ContentType 'application/json' -Body $payload
```

Inspect the received body. Publish the workflow and repeat with the Production URL, then inspect Executions. See [n8n Webhook documentation](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.webhook/).

If the tunnel URL changes, update `.env`, recreate the service with both Compose files and update external callers. The n8n restart policy does not keep the separate ngrok process running.

## Google OAuth

In Google Cloud, create or select a project and enable Google Sheets, Google Drive and Gmail APIs. Configure consent with your account as a test user, then create a Web application OAuth client.

Create the corresponding credential in n8n and copy its exact OAuth Redirect URL into Google's Authorized redirect URIs. In public mode this uses the tunnel's HTTPS hostname; in local mode the localhost callback works through the active SSH forwarding session.

Enter Client ID and Client Secret into n8n, complete Google sign-in and save. Create separate n8n credentials for Sheets and Gmail. Use the permissions needed by each integration. See [n8n's Google OAuth instructions](https://docs.n8n.io/integrations/builtin/credentials/google/oauth-single-service/).

For Sheets, create a test spreadsheet with columns `name` and `status`, then use Manual Trigger → Google Sheets, operation Get Row(s). For Gmail, use Manual Trigger → Gmail, resource Draft and operation Create, addressed to yourself. Inspect the returned row and the draft in Gmail.

Switching between local and public mode can change OAuth callback addresses. Register the exact callback required by each mode and reconnect the credential if necessary.

[Validation](validation.md) · [README](../README.md)

