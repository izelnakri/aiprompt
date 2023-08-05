FROM node:20.5.0-slim

RUN apt-get update \
  && apt-get install -y curl unzip wget gnupg git \
  && curl -fsSL https://deno.land/x/install/install.sh | sh \
  && echo 'export DENO_INSTALL="/root/.deno"; export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc

ENV DENO_INSTALL=/root/.deno PATH=${PATH}:/root/.deno/bin

WORKDIR /code/

ADD package.json package-lock.json /code/

RUN npm install

ADD shims /code/shims
ADD vendor /code/vendor
ADD test /code/test
ADD . /code/

ENTRYPOINT "/bin/bash"
