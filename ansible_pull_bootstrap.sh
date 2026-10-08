#!/usr/bin/env bash
set -e

# Ansible-pull bootstrap script.
REPO_URL="https://github.com/yourusername/dotfiles.git"

echo "==> Ensuring Git and Ansible are installed..."
if ! command -v ansible &> /dev/null; then
    sudo apt-get update -qq
    sudo apt-get install -y -qq git ansible
fi

echo "==> Pulling configuration from GitHub and applying playbook..."
ansible-pull -U "$REPO_URL" -i localhost, local.yml

echo "==> System environment sync complete!"


########################################################################

# Ansible bootstrap script that clones the repo first so you can run your shell script.
# This repo will need to be public and you will need to curl this script and pipe to bash to run it.
# Example curl:
curl -sSL https://raw.githubusercontent.com/yourusername/dotfiles/main/bootstrap.sh | bash

# Example bootstrap.sh file call:
git clone https://github.com/YourUserName/YourRepoName.git /tmp/Debian_Config && cd /tmp/Debian_Config && ./Debian_Config.sh && rm -rf /tmp/Debian_Config
