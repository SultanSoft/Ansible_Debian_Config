# Ansible Site Directory Structure (Debian Config)

This is a directory structure for Ansible to configure Debian linux and bash.

## Important Notes:

The working directory for ALL ansible-playbook commands must be the root Ansible folder where the ansible.cfg file is located.  This will tell ansible to use the config file in the Ansible directory and to not use default config file locations.

----------

### Purpose

This ansible structure is designed to run a Debian Linux and bash configuration playbook.

### Design

- This ansible structure contains a role named `role_debian_config` specifically for this purpose.
- Before running running the playbook, the `Debian_Config.sh` script installs ansible-core and whiptail.
- Whiptail is used to prompt the user to install optional software during ansible playbook execution.
- The playbook calls the `main.yml` task file in the `role_debian_config` role and all work is assigned to child task files from the `main.yml` controller.
- This role is **fully idempotent**, but will overwrite any changes made by the user to some files including the user's `~/.bash_custom` file.  Ideally, it should only need to be run once per Debian installation.

The following apps installed by this role are mandatory:
- sudo
- ca-certificates
- wget
- curl
- cmatrix
- nano
- htop

Optional apps that can be installed will be individually selectable before the playbook runs.

### Execution instructions:

In bash, run the `Debian_Config.sh` script from the project root directory which installs ansible-core and runs the playbook.
