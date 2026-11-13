# Portfolio Rebalancer

**Status:** Implemented and tested, including successful and unsuccessful executions.

I implemented a portfolio-rebalancing workflow: a form supplies the objective, an AI Agent reads and updates Google Sheets using Marketstack EOD data, and Gmail and Pushover communicate the result.

## Workflow

Form submission → AI Agent → If → success or failure push notification.

The AI Agent connects to a chat model and the following tools:

| Tool | Responsibility |
| --- | --- |
| Google Sheets read | Retrieve positions and reread the allocation after changes |
| Marketstack | Retrieve the latest available EOD prices |
| Google Sheets price update | Match the ticker and update the price |
| Google Sheets quantity update | Write the proposed quantity after rebalancing |
| Gmail | Send the report to the configured recipient |
| Pushover | Send an agent-generated summary |

The workflow keeps proposed quantities separate from original holdings. It updates a spreadsheet and sends reports; it does not execute brokerage trades.

## What I implemented

- Mapped the form input into the agent prompt.
- Gave the agent a business objective and instructions for using its tools.
- Described the portfolio-reading tool so that the agent uses it before and after updates.
- Inspected tool inputs, outputs and execution details.
- Configured the iteration limit for rebalancing.
- Combined an agent-selected notification tool with a fixed notification step.
- Routed the final completion response through an If node.
- Published the workflow and submitted the production form.

## Successful and unsuccessful versions

I executed both successful and unsuccessful versions. The work included refining the configuration and context, inspecting the agent's behavior and running the completed workflow.

The agent's completion response drives the conditional branch. It is a signal used by the workflow, not independent numerical validation. Reading the sheet again is part of the workflow's check of the proposed allocation.

## Agent tools and workflow steps

As a tool, Pushover is available for the agent to choose and supply with a message. After the If node, Pushover is a configured workflow step selected by the condition. I combined agent decisions with explicit process rules.

The form-driven request also differs from a conversation: the request contains the task, without requiring the chat assistant's conversation memory.

[Portfolio case study](https://github.com/wagner-stoffel/portfolio/tree/main/projects/01-equity-eod-ai-agent) · [Back to lab](../../README.md)
