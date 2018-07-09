FROM debian:stretch-slim
LABEL maintainer="zodern"
RUN apt-get update && \
  apt-get install -y curl python make g++ bzip2 libfontconfig1 libfreetype6  ca-certificates --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*
RUN export VERSION="2.1.1" && \
  curl -L -o ./phantomjs.tar.bz2 https://github.com/Medium/phantomjs/releases/download/v$VERSION/phantomjs-$VERSION-linux-x86_64.tar.bz2 && \
  mkdir phantomjs && \
  tar xvjf phantomjs.tar.bz2 -C ./phantomjs --strip-components=1  && \
  mv phantomjs /usr/local/share && \
  ln -sf /usr/local/share/phantomjs/bin/phantomjs /usr/local/bin && \
  rm -rf ./phantomjs ./phantomjs.tar.bz2
RUN useradd --create-home --shell /bin/bash --uid 1000 --user-group app

RUN mkdir /built_app
RUN mkdir /bundle
RUN chown -R app:app /home/app/ && chown -R app:app /built_app && chown -R app:app /bundle
RUN chmod 700 /built_app && chmod 700 /bundle

USER app
WORKDIR /home/app
RUN mkdir scripts && mkdir setup
COPY ./setup ./setup
RUN bash setup/install_nvm.sh

COPY ./scripts ./scripts

ONBUILD USER app
ONBUILD ARG NODE_VERSION='4.8.4'
ONBUILD RUN bash ./scripts/onbuild-node.sh
ONBUILD ENV NODE_PATH=/home/app/.onbuild-node/lib/node_modules
ONBUILD ENV PATH=/home/app/.onbuild-node/bin:$PATH

USER root
EXPOSE 3000
ENTRYPOINT bash /home/app/scripts/entry.sh
