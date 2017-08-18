#!/bin/sh
set -e

if [ -e /bundle/bundle.tar.gz ]; then
  cd /bundle

  chmod 777 *.tar.gz
  chown -R app:app *.tar.gz

  echo "=> Extracting bundle"
  tar --no-same-owner -xzf bundle.tar.gz

  cd /bundle/bundle

  echo "=> Setting node version"
  . /home/app/scripts/setup_nvm.sh

  echo "=> Installing npm dependencies"
  cd ./programs/server && npm install $NPM_INSTALL_OPTIONS

  cd ../..
else
  cd /built_app
  echo "=> Setting node version"  
  . /home/app/scripts/setup_nvm.sh
fi

export PORT=${PORT:-3000}
echo "=> Starting meteor app on port $PORT"
node main.js
 