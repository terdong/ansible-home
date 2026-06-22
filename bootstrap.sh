#!/bin/bash

sudo apt update

sudo apt install -y ansible

echo "Running Ansible Playbook..."
ansible-playbook site.yml