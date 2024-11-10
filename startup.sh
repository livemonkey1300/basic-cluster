#!/bin/bash
# Update package list and install python3-pip
apt update && apt install -y python3-pip

# Install Ansible using pip
pip3 install ansible

# Install the Ansible role for Docker
ansible-galaxy role install geerlingguy.docker
ansible-playbook playbooks.yaml