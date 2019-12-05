#!/usr/bin/env bash
OPTION="${1}"

case $OPTION in
            "windows")
    git clone --branch develop https://github.com/vector-im/riot-web.git \
    && cd riot-web/ \
    && jq 'del(.build.win.sign)' package.json > package.json.new \
    && rm package.json \
    && mv package.json.new package.json \
    && yarn install \
    && cp config.sample.json config.json \
    && sed -i -e 's/"showLabsSettings": false,/"showLabsSettings": true,/g' config.json \
    && yarn build \
    && yarn build:electron:windows \
    && cp -r ./electron_app/dist/ /data
    ;;
            "linux")
    git clone --branch develop https://github.com/vector-im/riot-web.git \
    && cd riot-web/ \
    && yarn install \
    && cp config.sample.json config.json \
    && sed -i -e 's/"showLabsSettings": false,/"showLabsSettings": true,/g' config.json \
    && yarn build \
    && yarn build:electron:linux \
    && cp -r ./electron_app/dist/ /data
    ;;
            *)
    echo "-=> unknown \'$OPTION\'"
    ;;
esac
