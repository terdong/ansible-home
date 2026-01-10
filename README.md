# HC4 Ansible - Infrastructure Automation

This repository contains Ansible playbooks and roles for the automated setup and optimization of **Odroid HC4** (Home Cloud 4) or similar NAS/Home Server systems.

## Project Overview

The goal of this project is to provide a reproducible, one-command setup for a stable and high-performance server environment. It covers everything from basic utilities to storage optimization and network sharing.

## Features & Roles

The main playbook (`site.yml`) executes the following roles:

- **`common`**: Installs essential utilities (git, curl, zip, etc.) and sets up the base environment.
- **`optimize`**: Applies system-level performance optimizations and kernel parameter tweaks.
- **`storage`**: Automates mounting of drives, `/etc/fstab` configuration, and optimal swappiness settings.
- **`log2ram`**: Extends SD card lifespan by mounting `/var/log` in RAM (requires reboot).
- **`zram`**: Configures RAM-based swap space with compression (zstd) to maximize available memory.
- **`samba`**: Sets up Network-Attached Storage (NAS) capabilities by configuring Samba shares.
- **`packages`**: Installs additional application packages tailored for the server environment.

## Prerequisites

- **Control Node**: Ansible installed on your local machine.
- **Managed Node**: Odroid HC4 running a Debian-based OS (e.g., Armbian, Ubuntu).
- **SSH**: Passwordless SSH access is recommended but can be configured in the inventory.

## Quick Start


### 0. Configure ansible.cfg
Edit `ansible.cfg` to match your configuration:
```cfg
# Connection account (Replace with your actual username)
remote_user = your_user_name
```

### 1. Configure Inventory
Edit `inventories/inventory.ini` to match your server's details:
```ini
[hc4]
your_ip ansible_user=your_user_name ansible_port=your_port ansible_python_interpreter=/usr/bin/python3
```

### 2. Customize Variables
Check `inventories/group_vars/hc4.yml` to define your Samba shares and system limits:
```yaml
samba_shares:
  - name: "name"
    path: "/foo/bar"
```

### 3. Run the Playbook
Execute the full setup:
```bash
ansible-playbook site.yml
```

To update only specific packages using tags:
```bash
ansible-playbook site.yml --tags "pkg_only"
```

## Project Structure

```text
.
├── ansible.cfg          # Ansible configuration defaults
├── site.yml             # Main project entry point
├── inventories/         # Connection and host variable definitions
│   └── group_vars/      # Environment-specific variables
└── roles/               # Modular automation components
    ├── common/          # Base setup
    ├── log2ram/         # SD card optimization
    ├── optimize/        # Performance tuning
    ├── samba/           # File sharing
    └── ...
```

## Contributing
Feel free to fork this repository and submit pull requests for any improvements or bug fixes.

---
*Maintained by Darren.*
