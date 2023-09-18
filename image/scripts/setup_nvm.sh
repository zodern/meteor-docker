set -e
export NVM_DIR="/home/app/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]
. "$NVM_DIR/nvm.sh"

NODE_VERSION="$(node /home/app/scripts/node-version.js)"
# Replace a possible 'v' prefix
NODE_VERSION="$(echo $NODE_VERSION | sed 's/^v//')"
echo "NODE_VERSION=$NODE_VERSION"

if [[ $DEBUG_NODE_VERSION == "0" ]]; then
  cat /home/app/scripts/log.txt || true
fi

MAJOR_NODE_VERSION=`echo $NODE_VERSION | awk -F. '{print $1}'`
MINOR_NODE_VERSION=`echo $NODE_VERSION | awk -F. '{print $2}'`

echo "Node: $NODE_VERSION"
echo "Major: $MAJOR_NODE_VERSION"
echo "Minor: $MINOR_NODE_VERSION"

if [[ $MAJOR_NODE_VERSION == "14" && $MINOR_NODE_VERSION -ge 21 ]]; then
  echo "Using Meteor's custom NodeJS v14 LTS version"
  # https://hub.docker.com/layers/meteor/node/14.21.4/images/sha256-f4e19b4169ff617118f78866c2ffe392a7ef44d4e30f2f9fc31eef2c35ceebf3?context=explore
  curl "https://static.meteor.com/dev-bundle-node-os/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" | tar xzf - -C /tmp/
  NEW_PATH="/tmp/node-v$NODE_VERSION-linux-x64/bin"
  export PATH="$NEW_PATH:$PATH"
  echo "PATH=$NEW_PATH:\$PATH" >> ~/.bashrc
  export NODE_PATH=$NEW_PATH
else
  echo "Using NVM"
  nvm install $NODE_VERSION
  nvm alias default $NODE_VERSION
  export NODE_PATH=$(dirname $(nvm which $(node --version)))
fi
