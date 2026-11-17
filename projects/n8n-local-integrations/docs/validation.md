# Execution record

I completed the local setup, public webhook configuration and Google OAuth integrations, then performed the following functional checks.

| Check | Observed result |
| --- | --- |
| Local editor | n8n opened at localhost:5678 and the owner account was configured |
| Local workflow | Manual Trigger and Edit Fields returned the configured status and environment fields |
| Test webhook | The POST request reached the listening Webhook node and its body was visible |
| Production webhook | The published endpoint received the POST request and created an execution |
| Google authorization | OAuth credentials were authorized for the selected Google account |
| Sheets retrieval | The configured test spreadsheet row was returned |
| Gmail draft | The draft was created and inspected in Gmail |

These are functional outcomes from my manual implementation. The Compose configuration and PowerShell helper package the reproduction steps; this record does not assign runtime measurements or automated-test results to those files.

[README](../README.md)

