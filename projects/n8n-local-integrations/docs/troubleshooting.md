# Troubleshooting

| Symptom | Check |
| --- | --- |
| Docker server unavailable | Start Docker Desktop and wait for its engine; run `docker version` |
| Port 5678 in use | Inspect `docker ps` and stop the existing local n8n instance before starting this package |
| First launch asks for a new account | This package uses its own volume, separate from the earlier n8n_data volume |
| Public URL missing during Compose validation | Set N8N_PUBLIC_URL in .env before loading compose.webhooks.yaml |
| Webhook URL still contains localhost | Start Compose with both files, then reload the editor |
| ngrok upstream connection error | Confirm localhost:5678 opens and the container is running |
| Test webhook returns 404 | Start listening again and confirm POST plus the copied Test URL |
| Production webhook returns 404 | Publish/activate the workflow and use its Production URL |
| redirect_uri_mismatch | Compare the n8n callback with the Google client's redirect URI exactly |
| Google access denied | Check the selected account, test-user registration and Workspace administrator restrictions |
| Spreadsheet unavailable | Check the authorized account, file access and enabled Drive and Sheets APIs |
| PowerShell blocks the helper | Use the equivalent request below without changing machine execution policy |

```powershell
$webhookUrl = 'https://YOUR-ACTUAL-DOMAIN.ngrok-free.app/webhook-test/technical-test'
$payload = @{ name = 'Wagner'; message = 'External webhook test' } | ConvertTo-Json
Invoke-RestMethod -Method Post -Uri $webhookUrl -ContentType 'application/json' -Body $payload
```

If Google displays an unverified-app screen, confirm that the app is the one you created and the account is your registered test user. Use Google's available testing flow only for that known app.

Inspect the current container state and recent logs:

```powershell
docker compose ps
docker compose logs --tail 100 n8n
```

[README](../README.md)
