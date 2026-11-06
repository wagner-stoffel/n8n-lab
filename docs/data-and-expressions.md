# JSON and expressions

I used JSON expressions to map data between the trigger, agent, memory and messaging nodes.

JSON represents structured data using objects, arrays, strings, numbers, booleans and null. Keys and strings use straight double quotes; JSON does not allow trailing commas.

Synthetic example:

```json
{
  "message": {
    "text": "What is today's date?",
    "chat": { "id": 123456 }
  }
}
```

I use a fictional ID here. These examples document the mappings I implemented with Telegram.

| Field | Example | Purpose |
| --- | --- | --- |
| Agent prompt after Telegram Trigger | `{{ $json.message.text }}` | Read incoming text |
| Reply text after AI Agent | `{{ $json.output }}` | Read the generated answer |
| Reply destination | `{{ $('Telegram Trigger').item.json.message.chat.id }}` | Recover the original chat ID |
| Memory session key | `{{ $('Telegram Trigger').item.json.message.chat.id }}` | Associate context with that chat |
| JSON as prompt text | `{{ JSON.stringify($json) }}` | Serialize structured data |

`$json` refers to the current input item. After the agent, the current item can contain its output rather than the original Telegram payload; reference the trigger when retrieving the destination.

The earlier node must have the referenced name and a linked item available. Inspect the expression preview against an actual execution. Messages without a text field need separate handling. For Slack, inspect its payload instead of copying Telegram's field paths.

I also keep earlier-node references in my notes through `$node["Node name"]`. Dragging an inspected field into an expression helps obtain the appropriate path.

Serializing JSON makes it text; it does not validate its contents or make untrusted messages safe instructions. Pass only necessary fields when designing a reusable workflow.

[Back to messaging experiments](../experiments/messaging/README.md)
