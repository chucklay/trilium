# !!! Don't try to build this Dockerfile directly, run it through bin/build-docker.sh script !!!
FROM node:17.1.0-alpine3.12

# Create app directory
WORKDIR /usr/src/app

COPY server-package.json package.json

# Install app dependencies
RUN set -x \
    && apk add --no-cache --virtual .build-dependencies \
        autoconf \
        automake \
        g++ \
        gcc \
        libtool \
        make \
        nasm \
        libpng-dev \
        python3 \
    && npm install --production \
    && apk del .build-dependencies

# Bundle app source
COPY . .

USER node

EXPOSE 8080
CMD [ "node", "./src/www" ]
