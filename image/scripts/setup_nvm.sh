set -e
export NVM_DIR="/home/app/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]
. "$NVM_DIR/nvm.sh"

NODE_VERSION="$(node /home/app/scripts/node-version.js)"
echo "NODE_VERSION=$NODE_VERSION"

if [[ $DEBUG_NODE_VERSION == "0" ]]; then
  cat /home/app/scripts/log.txt || true
fi

nvm install $NODE_VERSION
nvm alias default $NODE_VERSION
