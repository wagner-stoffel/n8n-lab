# Adding workflow exports and evidence

The Day 4 workflows were implemented by the author in n8n. This repository does not yet contain their actual exports. Do not substitute a newly invented workflow and describe it as the one executed.

## Suggested layout

Place reviewed exports beside the exercise notes:

- `week-01/day-04/workflows/pushover.json`
- `week-01/day-04/workflows/telegram.json`
- `week-01/day-04/workflows/slack.json`
- `week-01/day-04/evidence/` for sanitized screenshots or execution excerpts

These paths are reserved for future artifacts; they are not currently importable files.

## Review before committing

1. Export the actual workflow from n8n into a local `raw-exports/` directory.
2. Inspect node parameters, headers, URLs, pinned data and credential references. Remove tokens, Pushover user keys, signing secrets, private message contents and account identifiers.
3. Replace environment-specific values with clearly described placeholders. Record which credentials and IDs a new user must configure.
4. Save the reviewed copy under the exercise's `workflows/` directory.
5. Validate JSON syntax and test an import in a separate workflow before claiming reproducibility.
6. Add redacted evidence and update the validation record with actual results.

The .gitignore prevents common local files from being added accidentally; it does not inspect or sanitize JSON contents.

## Documentation standard

Each exercise should state purpose, architecture, configuration assumptions, implementation status, evidence, limitations and attribution. Record publication state and versions when known. A separate project repository becomes useful when a lab exercise grows into a reproducible solution with its own scope and validation.

[Back to lab](../README.md)
