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

sudo apt update

sudo apt install -y ansible

echo "Running Ansible Playbook..."
ansible-playbook site.yml
