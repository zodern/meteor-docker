set -e
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]
. "$NVM_DIR/nvm.sh"

NODE_VERSION="$(node $HOME/scripts/node-version.js)"
echo "NODE_VERSION=$NODE_VERSION"

if [[ $DEBUG_NODE_VERSION == "0" ]]; then
  cat /home/app/scripts/log.txt || true
fi

nvm install $NODE_VERSION
nvm use $NODE_VERSION
