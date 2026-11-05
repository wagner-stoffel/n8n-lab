# JSON and expressions — Day 4 notes

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

The ID is fictional. These expressions illustrate the lesson's Telegram flow; they are not an exported configuration from the author's instance.

| Field | Example | Purpose |
| --- | --- | --- |
| Agent prompt after Telegram Trigger | `{{ $json.message.text }}` | Read incoming text |
| Reply text after AI Agent | `{{ $json.output }}` | Read the generated answer |
| Reply destination | `{{ $('Telegram Trigger').item.json.message.chat.id }}` | Recover the original chat ID |
| Memory session key | `{{ $('Telegram Trigger').item.json.message.chat.id }}` | Associate context with that chat |
| JSON as prompt text | `{{ JSON.stringify($json) }}` | Serialize structured data |

`$json` refers to the current input item. After the agent, the current item can contain its output rather than the original Telegram payload; reference the trigger when retrieving the destination.

The earlier node must have the referenced name and a linked item available. Inspect the expression preview against an actual execution. Messages without a text field need separate handling. For Slack, inspect its payload instead of copying Telegram's field paths.

The lesson also introduces earlier-node references through `$node["Node name"]`. Dragging an inspected field into an expression helps obtain the appropriate path.

Serializing JSON makes it text; it does not validate its contents or make untrusted messages safe instructions. Pass only necessary fields when designing a reusable workflow.

[Back to Day 4](../week-01/day-04/README.md)
