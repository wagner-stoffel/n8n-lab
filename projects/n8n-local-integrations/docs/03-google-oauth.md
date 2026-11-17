# Google OAuth2, Sheets and Gmail

I configured custom OAuth2 credentials and tested spreadsheet retrieval and Gmail draft creation.

## 1. Create a Google project

Open [Google Cloud Console](https://console.cloud.google.com/), create `n8n Local Integrations` and select it. In **APIs & Services → Library**, enable Google Sheets API, Google Drive API and Gmail API. Sheets integration uses Drive as well as Sheets.

## 2. Configure consent

Open **Google Auth Platform → Get started**. Set the app name to `Wagner n8n Local` and provide your support and contact email. For a personal Gmail account, select External, keep Testing mode and add the account under **Audience → Test users**.

Review permissions under **Data Access**. Scopes describe the access requested by an integration; enabling an API alone does not authorize account access. Use permissions matching the selected operations and inspect the consent request before granting access. See [Google's consent configuration](https://developers.google.com/workspace/guides/configure-oauth-consent).

## 3. Obtain the callback

In n8n, add a Google Sheets node and create an OAuth2 credential. Copy its **OAuth Redirect URL**. For this setup it should be:

```text
http://localhost:5678/rest/oauth2-credential/callback
```

Google accepts a localhost redirect for development. Complete authorization in the browser on the computer running n8n; ngrok is not required for this local callback. Use the exact address shown in the credential. See [n8n's Google OAuth guide](https://docs.n8n.io/integrations/builtin/credentials/google/oauth-single-service/).

## 4. Create the client

In **Google Auth Platform → Clients**, create a **Web application** client named `n8n Local Client`. Add the copied callback under **Authorized redirect URIs**, then create the client.

The callback is a redirect URI, not a JavaScript origin. Protocol, hostname, port and path must match. See [Google's web application OAuth flow](https://developers.google.com/identity/protocols/oauth2/web-server).

Copy Client ID and Client Secret into the n8n credential. Click **Sign in with Google**, select the test-user account, review permissions, authorize and save. Keep the secret in the credential store, outside Git.

## 5. Test Google Sheets

Create a spreadsheet named `n8n OAuth Test` in the authorized account. In its first tab, enter:

| nome | status |
| --- | --- |
| Wagner | conectado |

Create `Manual Trigger → Google Sheets`. Select the saved credential, resource **Sheet Within Document**, operation **Get Row(s)**, the spreadsheet and its populated tab. Execute and inspect the returned row.

## 6. Test Gmail

Create `Manual Trigger → Gmail`. Add a Gmail OAuth2 credential. Reuse the Google client if its registered callback matches the Gmail credential's callback, then authorize Gmail access and save.

Set resource **Draft**, operation **Create**, your own address as recipient, subject `Teste OAuth n8n local` and message `Rascunho criado pelo meu n8n local.` Use text email format when offered. Execute, then inspect Gmail's Drafts folder.

These checks use [Google Sheets row operations](https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.googlesheets/) and [Gmail draft creation](https://docs.n8n.io/integrations/builtin/app-nodes/n8n-nodes-base.gmail/).

[Execution record](validation.md) · [README](../README.md)

