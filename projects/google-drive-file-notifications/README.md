# Google Drive File Notifications

**Status:** Implemented, tested and published.  
**Stack:** n8n · Google Drive · Google OAuth2 · Pushover

I built a workflow that monitors a Google Drive folder for new files and sends a push notification through Pushover.

## Workflow

```text
Google Drive Trigger → Pushover
```

The trigger checks a selected folder every minute for file creation. This is polling: n8n checks Google Drive periodically rather than receiving an incoming webhook.

## Implementation

I enabled Google Drive API in a Google Cloud project, configured an OAuth web application client and registered the redirect URL supplied by the n8n credential. I completed Google sign-in and confirmed the connected account.

I selected a dedicated file-drop folder in the Google Drive Trigger, used the File Created event and configured a one-minute polling interval. I connected Pushover using its application credential and recipient user key, then set a fixed file-arrival message with high priority.

I saved and published the workflow, created a copy of a file in the monitored folder and inspected the resulting execution.

## Result

The published workflow detected the new file, completed successfully and delivered the push notification. The polling interval describes the configured check frequency, not a measured delivery-time guarantee.

[Execution record](validation.md) · [Back to lab](../../README.md)
