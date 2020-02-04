#!/usr/bin/env bash
OPTION="${1}"

case $OPTION in
            "windows")
    git clone --branch develop --depth 1 https://github.com/matrix-org/matrix-js-sdk.git \
    && cd matrix-js-sdk/ \
    && yarn install && yarn link \
    && cd .. \
    && git clone --branch develop --depth 1 https://github.com/matrix-org/matrix-react-sdk.git \
    && cd matrix-react-sdk/ \
    && yarn link matrix-js-sdk \
    && yarn link && yarn install \
    && cd .. \
    && git clone --branch develop --depth 1 https://github.com/vector-im/riot-web.git \
    && cd riot-web/ ;\
    elecversion=$(cat package.json | jq '.build.electronVersion' | sed 's/"//g') ;\
    yarn link matrix-js-sdk && yarn link matrix-react-sdk \
    && jq 'del(.build.win.sign)' package.json > package.json.new \
    && rm package.json && mv package.json.new package.json \
    && yarn install \
    && cp config.sample.json config.json \
    && sed -i -e 's/"showLabsSettings": false,/"showLabsSettings": true,/g' config.json \
    && yarn build \
    && yarn build:electron:windows \
    && cp -r ./electron_app/dist/ /data
    ;;
            "linux")
    git clone --branch develop --depth 1 https://github.com/matrix-org/matrix-js-sdk.git \
    && cd matrix-js-sdk/ \
    && yarn install && yarn link \
    && cd .. \
    && git clone --branch develop --depth 1 https://github.com/matrix-org/matrix-react-sdk.git \
    && cd matrix-react-sdk/ \
    && yarn link matrix-js-sdk \
    && yarn link && yarn install \
    && cd .. \
    && git clone --branch develop --depth 1 https://github.com/vector-im/riot-web.git \
    && cd riot-web/ ;\
    elecversion=$(cat package.json | jq '.build.electronVersion' | sed 's/"//g') ;\
    jq '.dependencies += {"libsqlcipher0": "^3.2.0"}' package.json > package.json.new && mv package.json.new package.json ;\
    yarn link matrix-js-sdk && yarn link matrix-react-sdk \
    && yarn install \
    && curl https://riot.im/develop/config.json | jq '.features += {"feature_event_indexing": "labs"}' > config.json \
    && yarn add --dev electron@$elecversion \
    && cd electron_app/ \
    && yarn add matrix-seshat --ignore-scripts\
    && yarn add electron-build-env \
    && yarn run electron-build-env -- --electron $elecversion -- neon build matrix-seshat --release \
    && cd .. \
    && yarn build \
    && yarn build:electron:linux \
    && cp -r ./electron_app/dist/ /data
    ;;
            *)
    echo "-=> unknown \'$OPTION\'"
    ;;
esac
