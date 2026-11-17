# Functional validation procedure

Execute these checks against the running installation. Capture actual outputs in a private execution record, without publishing credentials or account data.

| Check | Procedure | Acceptance criterion |
| --- | --- | --- |
| Editor | Open n8n through SSH forwarding | Owner login and workflow editor load |
| Model availability | Run the container-network API check | qwen3:8b appears in the model list |
| GPU allocation | Inspect ollama ps and nvidia-smi during inference | Actual allocation is visible and recorded |
| Conversation | Send a greeting in Portuguese | Agent returns a relevant response |
| Tool use | Ask Calculator to evaluate 137 × 29 + 84 | Calculator appears in the execution; result is 4057 |
| Memory | State a project name, then ask for it in the same session | Agent retrieves the supplied name |
| Market data | Request an Apple closing price | Marketstack call and returned data are inspected |
| Test webhook | Listen and send a synthetic POST | Body arrives at the Webhook node |
| Production webhook | Publish and send to Production URL | Execution is recorded |
| Sheets | Retrieve the test row | Expected fields match the spreadsheet |
| Gmail | Create a draft | Draft appears in the selected account |
| Restart | Reboot the server after saving a workflow | Services return and workflow remains available |
| Restore | Restore a backup into an isolated Compose project | Workflow and credential availability can be checked |

A correct arithmetic answer alone does not prove tool use. Inspect node execution. A market-data response is a provider result, not an independently verified live quote.

After a server reboot, reconnect SSH forwarding. Restart ngrok separately before testing public endpoints. Keep published workflows in an isolated restore instance inactive until the restore environment's credentials and triggers have been reviewed.

[Backup and restore](backup-and-restore.md) · [README](../README.md)

