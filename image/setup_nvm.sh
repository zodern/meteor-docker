set -e
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]
. "$NVM_DIR/nvm.sh"

NODE_VERSION="$(node $HOME/scripts/node-version.js)"
echo "NODE_VERSION=$NODE_VERSION"

nvm install $NODE_VERSION

if [ -d $NVM_DIR/v${NODE_VERSION} ]; then
  rm -rf $NVM_DIR/versions/node/v$NODE_VERSION
  ln -s $NVM_DIR/v${NODE_VERSION} $NVM_DIR/versions/node/v$NODE_VERSION
fi

nvm use $NODE_VERSION

NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
echo $NODE_VERSION
echo $NVM_DIR
