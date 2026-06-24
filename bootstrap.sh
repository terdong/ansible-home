#!/bin/bash

USER_ID=$(whoami)

if [ ! -f "/etc/sudoers.d/$USER_ID" ]; then
    echo "Configuring sudoers for $USER_ID..."
    echo "$USER_ID ALL=(ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/$USER_ID" > /dev/null
    sudo chmod 0440 "/etc/sudoers.d/$USER_ID"
    echo "Sudoers configuration complete."
else
    echo "Sudoers configuration already exists for $USER_ID."
fi

if ! command -v ansible &> /dev/null; then
    echo "Ansible is not installed. Starting installation..."

    sudo apt update
    sudo apt install -y ansible
else
    echo "Ansible is already installed."
fi

echo "Running Ansible Playbook..."

ansible-galaxy install -r requirements.yml

ansible-playbook site.yml
