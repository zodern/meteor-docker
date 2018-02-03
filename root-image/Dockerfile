FROM zodern/meteor
LABEL maintainer="zodern"
USER root
ONBUILD USER root
ONBUILD ARG NODE_VERSION='4.8.4'
ONBUILD RUN bash ./scripts/onbuild-node.sh
ONBUILD ENV NODE_PATH=/home/app/.onbuild-node/lib/node_modules
ONBUILD ENV PATH=/home/app/.onbuild-node/bin:$PATH
ENTRYPOINT  bash /home/app/scripts/start.sh
