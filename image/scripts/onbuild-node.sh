. ./scripts/setup_nvm.sh

rm -rf /home/app/.onbuild-node
mkdir -p /home/app/.onbuild-node

ln -s $NODE_PATH /home/app/.onbuild-node
