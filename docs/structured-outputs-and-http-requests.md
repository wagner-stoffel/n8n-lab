# Structured Outputs and HTTP Requests

I used a structured query to connect an AI agent to a web-search operation, then forwarded the search results through an HTTP POST.

## Data contract

The Structured Output Parser example contains one string field:

```json
{
  "search_query": "internet search"
}
```

The downstream search node reads `{{ $json.output.search_query }}`. This separates query generation from search execution and makes the required input explicit.

A parser validates structure; it does not guarantee factual correctness or eliminate parsing failures. [Structured Output Parser](https://docs.n8n.io/integrations/builtin/cluster-nodes/sub-nodes/n8n-nodes-langchain.outputparserstructured/)

## JSON and raw request bodies

The implemented HTTP Request step sent `{{ $json.data }}` using the JSON body mode.

When a node/version combination requires explicit serialization, the equivalent raw-body configuration is:

| Field | Value |
| --- | --- |
| Method | POST |
| Send Body | Enabled |
| Body Content Type | Raw |
| Content Type | application/json |
| Body expression | `{{ JSON.stringify($json.data) }}` |

Use this raw expression when `data` is an object or array. Confirm the incoming field exists before sending; serializing an already-encoded JSON string would encode it again.

Raw mode is an alternative for controlling serialization, not a universal requirement for self-hosted n8n. [HTTP Request documentation](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.httprequest/)

## Firecrawl operation and output

The current node uses Resource **Map & Search** and Operation **Search Web**. Inspect the installed node's output before mapping fields: response structures can differ by node/API version. Search returns result metadata; scraping full page contents is a separate option. [Firecrawl integration](https://docs.firecrawl.dev/integrations/n8n)

Use the node's credential store for API authentication. Project variables are not required for the credential-based search workflow. Keep tokens out of repository files and endpoint examples.

## Google Drive authentication

n8n Cloud offers managed Google OAuth for Drive. Self-hosted installations use a custom OAuth client with the redirect URL copied from their own n8n credential. These URLs are environment-specific. [Google OAuth in n8n](https://docs.n8n.io/integrations/builtin/credentials/google/oauth-single-service/)

For a custom Google app in Testing mode, register the signing-in account under Audience → Test users in the app's own Google Cloud project. That setting does not grant access to a different developer's managed OAuth application.

[Search implementation](../projects/ai-web-search-pipeline/README.md) · [Drive notifications](../projects/google-drive-file-notifications/README.md) · [Back to lab](../README.md)
