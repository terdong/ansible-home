# Ansible-Home for Infrastructure Automation

This repository contains Ansible playbooks and roles for the automated setup and optimization of **Odroid HC4** (Home Cloud 4) or similar NAS/Home Server systems.

## Project Overview

The goal of this project is to provide a reproducible, one-command setup for a stable and high-performance server environment. It covers everything from basic utilities to storage optimization, containerization, and secure external access.

## Features & Roles

The main playbook (`site.yml`) executes the following roles:

- **`common`**: Installs essential utilities, sets timezone to **Asia/Seoul**, and configures a premium dev environment:
    - **Vim**: Custom `.vimrc` with OSC 52 clipboard support.
    - **Zsh**: Oh My Zsh with `macovsky-ruby` theme, `autosuggestions`, and `syntax-highlighting`.
- **`optimize`**: Applies system-level performance optimizations and kernel parameter tweaks.
- **`storage`**: Automates mounting of drives, `/etc/fstab` configuration (using UUIDs), and optimal swappiness settings.
- **`swapfile`**: Creates and enables a physical swap file for additional virtual memory.
- **`log2ram`**: Extends SD card lifespan by mounting `/var/log` in RAM.
- **`zram`**: Configures RAM-based swap space with compression (zstd) to maximize available memory.
- **`samba`**: Sets up Network-Attached Storage (NAS) capabilities by configuring Samba shares.
- **`packages`**: Installs additional application packages (e.g., `ncdu`, `htop`, `lm-sensors`).
- **`docker`**: Installs Docker Engine, configures `data-root`, and sets up `dockman` for stack management.
- **`nginx_proxy_manager`**: Deploys Nginx Proxy Manager (NPM) for easy reverse proxy and SSL management.
- **`cloudflare`**: Sets up Cloudflare Tunnel (`cloudflared`) for secure, no-port-forwarding external access.
- **`caddy`**: (Optional) Deploys Caddy server with automatic HTTP/3 support and simple reverse proxy configuration.

## Prerequisites

- **Control Node**: Ansible installed on your local machine.
- **Managed Node**: Odroid HC4 running a Debian-based OS (e.g., Armbian, Ubuntu).
- **SSH**: Passwordless SSH access is recommended.

## Quick Start

### 0. Configure ansible.cfg
Copy `ansible.cfg.example` to `ansible.cfg` and edit as needed.

### 1. Configure Inventory
Copy `inventories/inventory.ini.example` to `inventories/inventory.ini` and set your server's IP and user:
```ini
[hc4]
your_ip ansible_user=your_user_name ansible_port=your_port
```

### 2. Customize Variables
Copy `inventories/group_vars/all.yml.example` to `inventories/group_vars/all.yml` and define your paths and tokens.
Also, create `inventories/group_vars/hc4.yml` for host-specific settings like Samba shares and Caddy proxies.

### 3. Run the Playbook
Execute the full setup:
```bash
ansible-playbook site.yml
```

### Selective Execution (Tags)
You can run specific parts of the setup using tags:
- `common_only`: Only run common setup (Vim, Zsh, etc.)
- `pkg_only`: Only install/update packages
- `docker_only`: Only setup Docker and Dockman
- `swapfile_only`: Only manage swapfile
- `npm_only`: Only setup Nginx Proxy Manager
- `cloudflare_only`: Only setup Cloudflare Tunnel

## Project Structure

```text
.
├── site.yml             # Main project entry point
├── inventories/         # Host and group variable definitions
│   └── group_vars/      # Configuration variables
└── roles/               # Modular automation components
    ├── common/          # Base setup (Vim, Zsh, Timezone)
    ├── docker/          # Docker & Dockman setup
    ├── storage/         # Drive mounting & fstab
    ├── cloudflare/      # Cloudflare Tunnel
    ├── nginx_proxy_manager/ # NPM Container
    ├── caddy/           # Caddy Server
    └── ...
```

## Contributing
Feel free to fork this repository and submit pull requests for any improvements or bug fixes.

---
*Maintained by Darren.*
