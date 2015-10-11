#!/bin/bash

if [ ! -z "${GAME}" ];then
    echo "Fetching game..."
    curl -fsSL http://imdjh-dn.daoapp.io/${GAME} -o /usr/src/game-data
    file /usr/src/game-data > /var/tmp/game-data.result
    if [ $(grep -qi html /var/tmp/game-data.result) ];then
        echo 'Bad GAME selection, please try another one!'
        exit 1
    fi
    export WEPLAY_ROM="/usr/src/game-data"
fi

if [ ! -z "${REDIS_PORT_6379_TCP_ADDR}" ];then
    export WEPLAY_PORT_URI=${REDIS_PORT_6379_TCP_ADDR}:${REDIS_PORT_6379_TCP_PORT}
fi

export WEPLAY_SAVE_INTERVAL=120000

forever /srv/weplay-emu/index.js 