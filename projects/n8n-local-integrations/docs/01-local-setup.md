# Local installation

I configured a local n8n environment with persistent storage and verified workflow execution. The steps below reproduce that setup using the project's Compose configuration.

## 1. Prepare Docker

Check WSL in PowerShell:

```powershell
wsl --version
```

If WSL is absent, open PowerShell as administrator, run `wsl --install` and restart Windows. If it is already installed, run `wsl --update`.

Install [Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/) with the WSL 2 backend and Linux containers. Open Docker Desktop, wait for its engine to start, then check:

```powershell
docker version
docker compose version
```

Both Docker client and server should be available. See [Microsoft's WSL instructions](https://learn.microsoft.com/en-us/windows/wsl/install).

## 2. Prepare configuration

Open PowerShell in the project directory. Copy the example only when `.env` does not already exist:

```powershell
if (-not (Test-Path -LiteralPath .env)) { Copy-Item -LiteralPath .env.example -Destination .env }
```

The image is pinned to n8n 2.48.4 for this configuration package. This pin identifies the packaged runtime, not a measured version of the earlier manual executions.

If another n8n instance is already using port 5678, stop it in its terminal with Ctrl+C before starting this one. This package uses separate storage, so its first launch asks for a new local owner account.

## 3. Start n8n

```powershell
docker compose config --quiet
docker compose up -d
docker compose logs --tail 50 n8n
```

Open [the local editor](http://localhost:5678) and create the owner account. This is the account for this local instance.

Compose creates the `n8n_local_integrations_data` volume. It stores the database and configuration under `/home/node/.n8n`. Both timezone variables use `America/Sao_Paulo`.

## 4. Execute a local workflow

Create `Local Setup Test` and connect:

```text
Manual Trigger → Edit Fields (Set)
```

In Edit Fields, create two String fields:

| Field | Value |
| --- | --- |
| status | ok |
| environment | local |

Execute and inspect the output, then save the workflow. The executed check returned these configured fields.

## 5. Stop and resume

```powershell
docker compose stop
docker compose start
```

`stop` preserves the container and volume. `docker compose down` removes the project's containers and network while retaining the named volume. Do not add `--volumes` when preserving the stored workflows and credentials.

[Next: webhooks](02-webhooks.md) · [README](../README.md)

