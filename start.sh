#!/usr/bin/env bash
OPTION="${1}"

case $OPTION in
            "windows")
    git clone --branch develop https://github.com/matrix-org/matrix-js-sdk.git \
    && cd matrix-js-sdk/ \
    && yarn install && yarn link \
    && cd .. \
    && git clone --branch develop https://github.com/matrix-org/matrix-react-sdk.git \
    && cd matrix-react-sdk/ \
    && yarn link matrix-js-sdk \
    && yarn link && yarn install \
    && cd .. \
    && git clone --branch develop https://github.com/vector-im/riot-web.git \
    && cd riot-web/ \
    && yarn link matrix-js-sdk && yarn link matrix-react-sdk \
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
    git clone --branch develop https://github.com/matrix-org/matrix-js-sdk.git \
    && cd matrix-js-sdk/ \
    && yarn install && yarn link \
    && cd .. \
    && git clone --branch develop https://github.com/matrix-org/matrix-react-sdk.git \
    && cd matrix-react-sdk/ \
    && yarn link matrix-js-sdk \
    && yarn link && yarn install \
    && cd .. \
    && git clone --branch develop https://github.com/vector-im/riot-web.git \
    && cd riot-web/ \
    && yarn link matrix-js-sdk && yarn link matrix-react-sdk \
    && yarn install \
    && cp config.sample.json config.json \
    && sed -i -e 's/"showLabsSettings": false,/"showLabsSettings": true,/g' config.json \
    && yarn add electron@7.11.1 \
    && cd electron_app/ \
    && yarn add matrix-seshat \
    && yarn add electron-build-env \
    && yarn run electron-build-env -- --electron 7.11.1 -- neon build matrix-seshat --release \
    && cd .. \
    && yarn build \
    && yarn build:electron:linux \
    && cp -r ./electron_app/dist/ /data
    ;;
            *)
    echo "-=> unknown \'$OPTION\'"
    ;;
esac
