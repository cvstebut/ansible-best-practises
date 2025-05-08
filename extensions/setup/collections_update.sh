#!/bin/bash
set -e

COLOR_END='\e[0m'
COLOR_RED='\e[0;31m'

# This current directory.
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ROOT_DIR=$(cd "$DIR/../../" && pwd)
COLLECTIONS_DIR="$ROOT_DIR/plays/collections"
ROLES_REQUIREMENTS_FILE="$ROOT_DIR/roles/roles_requirements.yml"
COLLECTIONS_REQUIREMENTS_FILE="$ROOT_DIR/collections/collections_requirements.yml"
PYTHON_VIRTUALENV="$ROOT_DIR/.venv"

# Exit msg
msg_exit() {
    printf "$COLOR_RED$@$COLOR_END"
    printf "\n"
    printf "Exiting...\n"
    exit 1
}

# Trap if ansible-galaxy failed and warn user
cleanup() {
    msg_exit "Update failed. Please don't commit or push roles till you fix the issue"
}
trap "cleanup"  ERR INT TERM

# Check if python virtualenv has been setup
if [[ -d "$PYTHON_VIRTUALENV" ]]; then
  echo "Activating python virtual environment at '$PYTHON_VIRTUALENV'"
  source $PYTHON_VIRTUALENV/bin/activate
else
  msg_exit "Virtual Environment not created. Please run the setup.sh script before running this script."
fi

# Check ansible-galaxy
[[ -z "$(which ansible-galaxy)" ]] && msg_exit "Ansible is not installed or not in your path."

# Check collections req file
#[[ ! -f "$COLLECTIONS_REQUIREMENTS_FILE" ]]  && msg_exit "collections requirements '$COLLECTIONS_REQUIREMENTS_FILE' does not exist or permssion issue.\nPlease check and rerun."

# Remove existing collections
if [ -d "$COLLECTIONS_DIR" ]; then
    cd "$COLLECTIONS_DIR"
	if [ "$(pwd)" == "$COLLECTIONS_DIR" ];then
	  echo "Removing current collections in '$COLLECTIONS_DIR/*'"
	  rm -rf *
	else
	  msg_exit "Path error could not change dir to $COLLECTIONS_DIR"
	fi
fi



# Install collections without requirements file (did not get it to work)
ansible-galaxy collection install git+https://github.com/namolabs/ansible-collection-infra.git,v1.0.0 -p "$COLLECTIONS_DIR"
#ansible-galaxy collection install -r "$COLLECTIONS_REQUIREMENTS_FILE" --pre --force --no-deps -p "$COLLECTIONS_DIR"

exit 0
