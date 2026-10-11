#!/usr/bin/env bash
set -e

# Ansible bootstrap script.
REPO_URL="https://github.com/SultanSoft/Ansible_Debian_Config.git"

echo "==> Ensuring Git and Ansible are installed..."
if ! command -v git &> /dev/null; then
    sudo apt-get update -qq
    sudo apt-get install git -y -qq #ansible
fi

echo "==> Pulling configuration from GitHub and applying playbook..."
git clone "$REPO_URL" /tmp/Debian_Config && cd /tmp/Debian_Config && ./Debian_Config.sh && rm -rf /tmp/Debian_Config
#ansible-pull -U "$REPO_URL" -i localhost, local.yml
echo "==> Configuration complete!"
