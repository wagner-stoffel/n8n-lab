# Install and start the server

## 1. Prepare Ubuntu

Install Ubuntu Server 24.04 LTS on the dedicated machine. Enable OpenSSH, create a non-root administrator and connect Ethernet. Reserve the server's address through the router's DHCP configuration.

From the Windows notebook, connect using the actual user and address:

```powershell
ssh YOUR_USER@SERVER_LAN_IP
```

Configure SSH key authentication and confirm it works before changing password-login settings. Keep administrative access within your trusted network.

## 2. Install the runtime

Follow the [Docker Engine installation for Ubuntu](https://docs.docker.com/engine/install/ubuntu/) using the official apt repository, including the Compose plugin. Install a compatible NVIDIA driver and [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html).

Check the driver and Docker installation:

```bash
nvidia-smi
sudo docker version
sudo docker compose version
```

Configure the NVIDIA runtime after installing the toolkit:

```bash
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

The Docker restart also affects other running containers on this host. See [Ollama's Docker instructions](https://docs.ollama.com/docker).

## 3. Prepare the project

Copy this project to a directory owned by your administrator account, such as `~/homelab-ai`. Enter that directory. Create `.env` without overwriting an existing configuration:

```bash
test -f .env || cp .env.example .env
chmod 600 .env
sudo docker compose config --quiet
sudo docker compose up -d
sudo docker compose ps
```

The default port is 5680, so the lab can coexist with an earlier installation on 5678. No model is downloaded during startup.

## 4. Open the editor

In a separate Windows PowerShell window, establish SSH forwarding:

```powershell
ssh -N -L 5680:127.0.0.1:5680 YOUR_USER@SERVER_LAN_IP
```

Keep the window open and browse to [localhost:5680](http://localhost:5680). Create the n8n owner account. This address works because SSH forwards the notebook's port to the server's loopback port.

## 5. Download and inspect the model

Back in the server terminal:

```bash
sudo docker compose exec ollama ollama pull qwen3:8b
sudo docker compose exec ollama ollama list
sudo docker compose exec ollama ollama run qwen3:8b
```

Send a short greeting; use `/bye` to leave the interactive conversation. While the model is loaded, inspect processor allocation and GPU activity:

```bash
sudo docker compose exec ollama ollama ps
nvidia-smi
```

The model file is approximately 5.2 GB; runtime memory also includes context and processing overhead. Adjust workloads based on observed resource use rather than file size alone.

## 6. Check container networking

```bash
sudo docker compose exec n8n node -e "fetch('http://ollama:11434/api/tags').then(r=>{if(!r.ok)throw new Error('HTTP '+r.status);return r.json()}).then(console.log).catch(e=>{console.error(e);process.exit(1)})"
```

The response should list the downloaded model. The service hostname `ollama` resolves inside the shared Docker network.

[Integrations](integrations.md) · [README](../README.md)

