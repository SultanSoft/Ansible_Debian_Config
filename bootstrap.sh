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


########################################################################

# Ansible bootstrap script that clones the repo first so you can run your shell script.
# This repo will need to be public and you will need to curl this script and pipe to bash to run it.
# Example curl:
#curl -sSL https://raw.githubusercontent.com/SultanSoft/Ansible_Debian_Config/master/bootstrap.sh | bash
#curl -sSL https://raw.githubusercontent.com/SultanSoft/Ansible_Debian_Config/refs/heads/master/bootstrap.sh | bash

# Example bootstrap.sh file call:
#git clone https://github.com/YourUserName/YourRepoName.git /tmp/Debian_Config && cd /tmp/Debian_Config && ./Debian_Config.sh && rm -rf /tmp/Debian_Config
