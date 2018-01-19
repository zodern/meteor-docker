. ./scripts/setup_nvm.sh

NODE_PATH=$(dirname $(nvm which $(node --version)))

rm -rf /home/app/.onbuild-node
mkdir -p /home/app/.onbuild-node

ln -s $NODE_PATH /home/app/.onbuild-node
