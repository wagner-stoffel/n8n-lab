# AI Web Search Pipeline

**Status:** Implemented and tested.  
**Stack:** n8n · OpenRouter · DeepSeek V3.2 · Simple Memory · Structured Output Parser · Firecrawl · HTTP Request

I built a workflow that converts a natural-language question into a structured search query, retrieves web results and posts those results to an external endpoint.

## Workflow

```text
Chat Trigger → AI Agent → Firecrawl → HTTP Request → Webhook.site
                  ├── OpenRouter Chat Model
                  ├── Simple Memory
                  └── Structured Output Parser
```

Firecrawl runs as the next workflow step after the agent. The structured query connects the model's output to that step's input.

## Query generation

I configured the agent to produce an internet search query that best answers the user's question. I enabled Require Specific Output Format and attached a Structured Output Parser using this JSON example:

```json
{
  "search_query": "internet search"
}
```

The parser derives the field name and type from the example. The example value is illustrative, not a fixed search phrase.

I mapped the Firecrawl query input to:

```text
{{ $json.output.search_query }}
```

## Search and delivery

I installed the Firecrawl node, configured its API credential and connected its web-search operation. The current operation labels are Resource **Map & Search**, Operation **Search Web**; earlier node versions used a different search-action label.

I configured HTTP Request with method POST, Send Body enabled and a JSON body taken from:

```text
{{ $json.data }}
```

The destination was a Webhook.site request-inspection endpoint. I inspected both the returned search results and the received POST body.

## Results

I tested a question about which LLMs to use in 2026. The agent produced a structured search query, Firecrawl returned URLs, titles and descriptions, and the HTTP Request node delivered the result payload to Webhook.site.

The endpoint displayed a POST request containing the search-result content, and the workflow execution completed successfully.

[Execution record](validation.md) · [Structured outputs and HTTP requests](../../docs/structured-outputs-and-http-requests.md) · [Portfolio case](https://github.com/wagner-stoffel/portfolio/tree/main/projects/10-ai-web-search-pipeline) · [Back to lab](../../README.md)
