#!/bin/sh
set -e

if [ -e /bundle/bundle.tar.gz ]; then
  echo "Found /bundle/bundle.tar.gz"
  cd /bundle

  chmod -v 777 bundle.tar.gz || true

  echo "=> Extracting bundle"

  TAR_OPTIONS=$([ $EUID == 0 ] && echo "" || echo "--no-same-owner")
  NPM_OPTIONS=$([ $EUID == 0 ] && echo " --unsafe-perm" || echo "")

  tar $TAR_OPTIONS -xzf bundle.tar.gz

  cd /bundle/bundle

  echo "=> Setting node version"
  . /home/app/scripts/setup_nvm.sh

  echo "=> Installing npm dependencies"
  cd ./programs/server && npm install $NPM_OPTIONS $NPM_INSTALL_OPTIONS

  cd ../..
else
  cd /built_app
  echo "=> Setting node version"  
  . /home/app/scripts/setup_nvm.sh
fi

export PORT=${PORT:-3000}
echo "=> Starting meteor app on port $PORT"
node main.js
