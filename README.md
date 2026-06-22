# Ansible Environment Configuration for WSL & Ubuntu

This repository contains Ansible playbooks and roles designed to automate the setup, configuration, and optimization of a local **WSL (Windows Subsystem for Linux)** or **Ubuntu Desktop** environment.

## Project Overview

The goal of this project is to provide a reproducible, one-command setup for a stable and high-performance development environment. It automates system updates, installs daily utility tools, removes bloated packages, and configures a highly optimized CLI environment with Zsh, Oh My Zsh, and Vim.

---

## Features & Roles

The main playbook ([site.yml](file:///home/darren/projects_etc/ansible-home/site.yml)) executes the following modular roles:

### 1. **`system`** (System-Level Configurations)
*Executed with elevated privileges (`become: true`)*
- **WSL Auto-Detection**: Checks if the running kernel belongs to WSL.
- **Timezone Configuration**: Sets the system timezone to `Asia/Seoul`.
- **Hostname Configuration**: Configures a custom system hostname if defined.
- **Package Upgrades**: Updates the apt package cache and upgrades all packages to their latest versions.
- **Utility Installations**: Installs key utilities: `btop`, `git`, `curl`, `wget`, `httpie`, and `iproute2`.
- **Cleanup / Debloat**: Purges deprecated or unnecessary packages from the system:
  - `telnet` & `ftp` (Insecure protocols)
  - `friendly-recovery` (Unused recovery tools on headless/development environments)
  - `byobu` (If tmux/screen is preferred)
- **Dependency Optimization**: Runs autoremove and purges unused dependencies to keep the system clean.

### 2. **`user`** (User Space Setup)
*Executed in user space (`become: false`)*
- **Vim Setup**: Sets up a custom `.vimrc` with:
  - Line numbers and relative line numbering for efficient navigation.
  - Search highlighting and smart case sensitivity.
  - Smart tab configurations (4 spaces).
  - Remote clipboard integration using **OSC 52** (enables clipboard sharing across SSH/WSL).
- **Zsh Setup**: Configures Zsh as the default shell:
  - Installs Oh My Zsh.
  - Downloads and enables key plugins: `zsh-autosuggestions` and `zsh-syntax-highlighting`.
  - Sets the theme to `macovsky-ruby` with an added timestamp to the prompt.
  - Automatically appends local binary path (`~/.local/bin`) to `$PATH`.
- **Antigravity CLI**: Automatically installs the Antigravity CLI tools to `~/.local/bin/agy`.
- **Antigravity Customization (Skills)**: Ensures the skill directory exists (`~/.gemini/antigravity-cli/skills`) and copies the `general-rules` customization files.

---

## Prerequisites

- **Ansible Control Node**: Ansible installed on your machine.
- **OS**: Ubuntu or Ubuntu running on WSL (Windows Subsystem for Linux).
- **Privilege Escalation**: sudo access on the target host.

---

## Quick Start

### 1. Configure the Inventory
Review the inventory file [inventories/inventory.ini](file:///home/darren/projects_etc/ansible-home/inventories/inventory.ini):
```ini
[my_desktop]
localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3
```

### 2. Customize Group Variables
Edit [inventories/group_vars/all.yml](file:///home/darren/projects_etc/ansible-home/inventories/group_vars/all.yml) to configure custom hostname and directories:
```yaml
# Config directory
config_dir: "{{ ansible_env.HOME }}/.config"

# Custom hostname for the system (optional)
# custom_hostname: "my-desktop"
```

### 3. Run the Playbook
Run the full environment setup:
```bash
ansible-playbook site.yml
```

### Selective Execution (Tags)
To save time, run only specific roles by using tags:
- **Configure system and install packages**:
  ```bash
  ansible-playbook site.yml --tags system_only
  ```
- **Configure user environment (Vim & Zsh)**:
  ```bash
  ansible-playbook site.yml --tags user_only
  ```

---
*Maintained by Darren.*
