# This script installs ansible and then runs the ansible playbook "Localhost_Debian_Server.yml" file in the ./playbooks folder which targets only the localhost system.

sudo echo ""
sudo echo "This script installs ansible and then runs the ansible playbook 'playbook.yml'."
read -sp "Enter Ansible 'Become' (root) Password:" ansible_become_pass

# Validate ansible.done file.
if ! test -f ./ansible.done ; then

    # Install latest Ansible and dependencies. This is not idempotent!
    sudo apt update -y
    sudo apt install whiptail ansible-core --no-install-recommends -y
fi

# Optional package checklist definition: <tag> <item_label> <status>
optional_apps=(
    "starship"        "Custom bash prompt (custom script)"  OFF
    "micro"           "Terminal editor (custom script)"     OFF
    "nala"            "Frontend for apt"                    OFF
    "mc"              "Midnight Commander"                  OFF
    "git"             "Version control"                     OFF
    "timeshift"       "System snapshots"                    OFF
    "openssh-server"  "OpenSSH server daemon"               OFF
)

# Dynamically calculate internal list height based on item count
num_items=$(( ${#optional_apps[@]} / 3 ))

# Whiptail checklist dialog
if ! optional_apps_selected=$(whiptail --title "Optional App Installer" \
    --checklist "Select applications to install:" \
    22 76 "$num_items" "${optional_apps[@]}" 3>&1 1>&2 2>&3); then
    echo "Installation cancelled by user."
    exit 0
fi

# Trim quotes from returned optional_apps_selected
OPTIONAL_APP_LIST=$(echo "$optional_apps_selected" | tr -d '"')

# Run the Playbook.
ansible-playbook playbooks/Debian_Config.yml -e "ansible_become_pass=$ansible_become_pass" -e "optional_app_list='$OPTIONAL_APP_LIST'" -vv #--check

# Create ansible.done file to prevent commands above from running more than once.
touch ./ansible.done

# Clear become password.
ansible_become_pass=""


##################################################################
# Notes:

# This playbook is only designed to run on localhost.
# Otherwise, ansible-playbook will use the inventory file and default to 'all' hosts.

# As long as this script is called from the project root directory (working directory or pwd), it will use the config file and inventory in this directory.
# Otherwise it will use one of the default locations for config and inventory which is not what is desired.

