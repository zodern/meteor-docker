#!/bin/sh
set -e

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

export NVM_DIR="/home/app/.nvm" 
[ -s "$NVM_DIR/nvm.sh" ] 
. "$NVM_DIR/nvm.sh"

# initial version used during setup
nvm install 8.4.0

node /home/app/setup/install_node.js

DEFAULT_VERSION="$(node /home/app/setup/default_node.js)"
nvm alias default $DEFAULT_VERSION
nvm use $DEFAULT_VERSION

nvm uninstall 8.4.0
nvm cache clear
