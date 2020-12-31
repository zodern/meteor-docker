FROM zodern/meteor
LABEL maintainer="zodern"
USER root
RUN apt-get update && \
  apt-get install -y libfontconfig1 libfreetype6 && \
  rm -rf /var/lib/apt/lists/*
RUN export VERSION="2.1.1" && \
  curl -L -o ./phantomjs.tar.bz2 https://github.com/Medium/phantomjs/releases/download/v$VERSION/phantomjs-$VERSION-linux-x86_64.tar.bz2 && \
  mkdir phantomjs && \
  tar xvjf phantomjs.tar.bz2 -C ./phantomjs --strip-components=1  && \
  mv phantomjs /usr/local/share && \
  ln -sf /usr/local/share/phantomjs/bin/phantomjs /usr/local/bin && \
  rm -rf ./phantomjs ./phantomjs.tar.bz2
ONBUILD USER root
ONBUILD ARG NODE_VERSION='8.17.0'
ONBUILD ARG EXACT_NODE_VERSION=true
ONBUILD RUN bash ./scripts/onbuild-node.sh
ONBUILD ENV NODE_PATH=/home/app/.onbuild-node/lib/node_modules
ONBUILD ENV PATH=/home/app/.onbuild-node/bin:$PATH
ENTRYPOINT  bash /home/app/scripts/start.sh
