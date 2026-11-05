# Messaging — validation notebook

I have built the Pushover, Telegram and Slack integrations. This notebook is where I plan to record individual execution results and investigate their limits.

I still need to attach execution details for the checks below. The expected outcomes describe what I want to verify, rather than results already recorded here.

## Integration checks

| ID | What I want to check | Expected outcome | My record |
| --- | --- | --- | --- |
| MSG-01 | Request a dated push notification | Delivered content matches the date-tool output | Details to add |
| MSG-02 | Message the Telegram bot | The reply reaches the originating chat | Details to add |
| MSG-03 | Introduce a name and ask for it in the same chat | Relevant context is used | Details to add |
| MSG-04 | Message Telegram after publishing | Execution starts without a manual test | Details to add |
| MSG-05 | Mention the Slack bot | The workflow receives the event and replies | Details to add |
| MSG-06 | Use the Slack production webhook | The verified URL receives the event | Details to add |
| MSG-07 | Ask for the current date | The answer matches the date tool and timezone | Details to add |

## Limits I want to investigate

| ID | Scenario | What I want to establish | Status |
| --- | --- | --- | --- |
| MSG-08 | Separate Telegram chats | Context and replies stay within their intended chat | To validate |
| MSG-09 | Message without text | The workflow handles the missing field explicitly | To validate |
| MSG-10 | Revoked credential or unavailable service | A failed delivery is reported accurately | To validate |
| MSG-11 | Repeated event | I understand and handle duplicate processing | To validate |
| MSG-12 | Invalid Slack signature | Request verification rejects the event | To validate |
| MSG-13 | Workflow export | Shared files contain no secrets or private content | Export review pending |

## How I will record a run

I will capture the date, workflow and node versions, model, input, expected outcome, observed outcome and pass/fail result. I will attach a reviewed screenshot or execution excerpt and record timing or token use only when measured.

I still need to document the current publication state of each workflow.

[Back to messaging experiments](README.md)
