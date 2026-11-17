# Public webhooks with ngrok

I configured a public tunnel and tested POST delivery to n8n's test and production webhook endpoints.

## 1. Install and authenticate

Create an [ngrok account](https://dashboard.ngrok.com/signup) and install the Windows agent from the [download page](https://ngrok.com/download). In a new PowerShell window:

```powershell
ngrok version
ngrok config add-authtoken "REPLACE_WITH_YOUR_AUTHTOKEN"
ngrok http http://localhost:5678
```

Keep this window open. Copy the actual HTTPS forwarding address shown by ngrok. The token belongs in ngrok's local configuration, not in this repository.

## 2. Set the public URL

Edit `.env` in the project directory. Set:

```dotenv
N8N_PUBLIC_URL=https://YOUR-ACTUAL-DOMAIN.ngrok-free.app/
```

Use the actual address, including a trailing slash. In another terminal, from the project directory:

```powershell
docker compose -f compose.yaml -f compose.webhooks.yaml config --quiet
docker compose -f compose.yaml -f compose.webhooks.yaml up -d
```

Continue using [localhost](http://localhost:5678) for the editor. The override configures `N8N_WEBHOOK_URL` and one trusted proxy hop. The package targets n8n 2.35 or later; older versions use `WEBHOOK_URL` instead. See [n8n's proxy configuration](https://docs.n8n.io/hosting/configuration/configuration-examples/webhook-url/).

The tunnel also exposes the n8n interface at its public address. Keep the owner login configured and close the tunnel when the session ends.

## 3. Create the test endpoint

Create `Public Webhook Test`, add a Webhook node and configure:

| Setting | Value |
| --- | --- |
| HTTP Method | POST |
| Path | technical-test |
| Authentication | None for this synthetic-data test |
| Respond | Immediately |

Select Test URL and click **Listen for test event**. Copy the exact URL shown by the node. It should use ngrok and contain `/webhook-test/technical-test`.

Send the request from a separate PowerShell window:

```powershell
.\scripts\Send-WebhookTest.ps1 -WebhookUrl "https://YOUR-ACTUAL-DOMAIN.ngrok-free.app/webhook-test/technical-test"
```

Inspect the Webhook output. Its `body` should contain `name` and `message`.

## 4. Test the production endpoint

Save and publish the workflow (activate it on older interfaces). Copy its Production URL and send a second request:

```powershell
.\scripts\Send-WebhookTest.ps1 -WebhookUrl "https://YOUR-ACTUAL-DOMAIN.ngrok-free.app/webhook/technical-test"
```

Inspect **Executions**. Test endpoints require manual listening; production endpoints require a published workflow. See [Webhook behavior](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.webhook/).

## 5. Resume another session

Restart ngrok and check its address. If it changes, update `.env`, rerun the two-file Compose startup and update external webhook callers. The Google OAuth callback stays local in this configuration.

Stop ngrok with Ctrl+C. Stop the container with:

```powershell
docker compose -f compose.yaml -f compose.webhooks.yaml stop
```

[Next: Google OAuth](03-google-oauth.md) · [README](../README.md)

