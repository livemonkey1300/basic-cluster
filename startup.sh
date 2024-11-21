#!/bin/bash
# Update package list and install python3-pip
apt update && apt install -y python3-pip python3 python3.12-venv

# Install the new environement 
python3 -m venv ~/.venv
source ~/.venv/bin/activate

# Install the pip package 
pip install ansible

# Install the Ansible role for Docker
ansible-galaxy role install geerlingguy.docker
ansible-playbook playbooks.yaml