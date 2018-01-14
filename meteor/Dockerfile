FROM debian:wheezy-slim
LABEL maintainer="zodern"
RUN apt-get update
RUN apt-get install -y git curl python make build-essential bash
RUN adduser --disabled-password --gecos "" app

RUN mkdir /built_app
RUN mkdir /bundle
RUN chown -R app:app /home/app/ && chown -R app:app /built_app && chown -R app:app /bundle
RUN chmod 700 /built_app && chmod 700 /bundle

USER app
WORKDIR /home/app
RUN mkdir scripts && mkdir setup
COPY ./setup ./setup
RUN setup/install_nvm.sh

COPY ./setup_nvm.sh scripts/setup_nvm.sh
COPY ./start.sh scripts/start.sh
COPY ./node-version.js scripts/node-version.js

ONBUILD ARG NODE_VERSION='4.8.4'
ONBUILD ENV NVM_DIR /root/.nvm
ONBUILD RUN /scripts/setup_nvm.sh
ONBUILD ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ONBUILD ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

EXPOSE 3000
ENTRYPOINT /home/app/scripts/start.sh
