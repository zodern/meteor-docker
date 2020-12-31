#!/bin/sh

cat <<'EOF' >> /root/.bashrc
export NVM_DIR="/home/app/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
EOF
