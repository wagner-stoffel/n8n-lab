# Portfolio Rebalancer — Day 5

**Status:** Exercises completed, including successful and unsuccessful versions.

I connected the integrations explored earlier in the course into a portfolio-rebalancing workflow: a form supplies the objective, an AI Agent reads and updates Google Sheets using Marketstack EOD data, and Gmail and Pushover communicate the result.

## Workflow

Form submission → AI Agent → If → success or failure push notification.

The AI Agent connects to a chat model and the following tools:

| Tool | Role in the exercise |
| --- | --- |
| Google Sheets read | Retrieve positions and reread the allocation after changes |
| Marketstack | Retrieve the latest available EOD prices |
| Google Sheets price update | Match the ticker and update the price |
| Google Sheets quantity update | Write the proposed quantity after rebalancing |
| Gmail | Send the report to the configured recipient |
| Pushover | Send an agent-generated summary |

The exercise keeps proposed quantities separate from original holdings. It updates a spreadsheet and sends reports; it does not execute brokerage trades.

## What I practiced

- Mapping the form input into the agent prompt.
- Giving the agent a business objective and instructions for using its tools.
- Describing the portfolio-reading tool so that the agent uses it before and after updates.
- Inspecting tool inputs, outputs and execution details.
- Exploring iteration settings during the rebalance.
- Comparing an agent-selected notification tool with a fixed notification step.
- Routing the final completion response through an If node.
- Publishing the workflow and submitting the production form.

## Successful and unsuccessful versions

I executed both kinds of version during the exercises. The work included refining the configuration and context, inspecting the agent's behavior and running the completed workflow.

The agent's completion response drives the conditional branch. It is a signal used by the workflow, not independent numerical validation. Reading the sheet again is part of the exercise's check of the proposed allocation.

## Agent tools and workflow steps

As a tool, Pushover is available for the agent to choose and supply with a message. After the If node, Pushover is a configured workflow step selected by the condition. This distinction helped me combine agent decisions with explicit process rules.

The form-driven request also differs from a conversation: the request contains the task, without requiring the chat assistant's conversation memory.

[Portfolio case study](https://github.com/wagner-stoffel/portfolio/tree/main/projects/01-equity-eod-ai-agent) · [Back to lab](../../README.md)
