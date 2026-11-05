# How I prepare workflows for sharing

I want someone else to be able to understand and reproduce an experiment without exposing my credentials or private messages. I have built the messaging workflows in n8n; adding reviewed exports is my next documentation step.

## Where I will keep the artifacts

- `experiments/messaging/workflows/pushover.json`
- `experiments/messaging/workflows/telegram.json`
- `experiments/messaging/workflows/slack.json`
- `experiments/messaging/evidence/` for reviewed screenshots and execution excerpts

These are planned locations. I have not added the artifacts yet.

## My preparation checklist

1. I export the actual workflow into a local `raw-exports/` directory.
2. I review parameters, headers, URLs, pinned data and credential references for secrets and private information.
3. I replace environment-specific values with documented placeholders.
4. I save the reviewed copy alongside the experiment.
5. I validate the JSON and check the import in a separate workflow before calling it reproducible.
6. I record the observed results in the validation notebook.

My .gitignore helps keep local configuration and raw exports out of commits. It does not sanitize the contents of a workflow.

## What I want each experiment to explain

I document the purpose, data flow, configuration assumptions, observations, limitations and next questions. I record versions and deployment state when I capture execution evidence.

[Back to lab](../README.md)
