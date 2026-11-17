# Backup and restore

The n8n volume contains the SQLite database and configuration, including the encryption material needed to read credentials. Back up the complete volume and protect the archive as sensitive data.

## Create a consistent backup

Run from the project directory on Ubuntu. Pull the small archive utility image before stopping n8n:

```bash
sudo docker pull alpine:3.22
mkdir -p backups
chmod 700 backups
backup_file="n8n-$(date -u +%Y%m%dT%H%M%SZ).tar.gz"
sudo docker compose stop n8n
```

Archive the project-scoped volume read-only:

```bash
sudo docker run --rm --mount type=volume,src=homelab-ai_n8n_data,dst=/data,readonly --mount type=bind,src="$PWD/backups",dst=/backup alpine:3.22 tar -czf "/backup/$backup_file" -C /data .
```

Check the command's exit status and inspect the archive before retaining it as a backup. Restart n8n even if archival fails, then investigate the failure:

```bash
sudo docker compose start n8n
sudo chmod 600 "backups/$backup_file"
sudo tar -tzf "backups/$backup_file"
```

Copy the archive and a protected copy of `.env` and Compose files to the separate backup drive. Local copies in `backups/` alone do not protect against host disk loss. Preserve model names and image references; downloaded models can be fetched again or the Ollama volume can be archived separately while Ollama is stopped.

## Restore into an isolated instance

Select the actual archive filename. Create a dedicated volume and restore there, preserving the active installation:

```bash
sudo docker volume create homelab-restore_n8n_data
sudo docker run --rm --mount type=volume,src=homelab-restore_n8n_data,dst=/data --mount type=bind,src="$PWD/backups",dst=/backup,readonly alpine:3.22 tar -xzf /backup/REPLACE_WITH_ARCHIVE_FILENAME.tar.gz -C /data
```

Before starting the restored application, disable workflow activation in its copied database using n8n's CLI:

```bash
sudo N8N_HOST_PORT=5681 docker compose -p homelab-restore run --rm --no-deps n8n unpublish:workflow --all
sudo N8N_HOST_PORT=5681 docker compose -p homelab-restore up -d n8n
```

Use the same n8n image version as the backed-up installation. The `-p homelab-restore` project name selects separate volumes. Do not load the public override for this restore check.

Only start the restored service after the unpublish command succeeds. See [n8n's command-line reference](https://docs.n8n.io/hosting/cli-commands/).

Forward notebook port 5681 to server loopback port 5681 through SSH. Inspect the workflows and credentials in the restored instance. Review triggers and external side effects before executing any workflow.

Stop the isolated instance after inspection:

```bash
sudo N8N_HOST_PORT=5681 docker compose -p homelab-restore down
```

The named restore volume remains available. Do not delete the primary volume as part of a restore check.

[README](../README.md)
