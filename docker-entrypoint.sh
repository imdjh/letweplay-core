#!/bin/bash
set -e

export WEPLAY_SAVE_INTERVAL=${SAVE_DELAY:-120000}
export WEPLAY_ROM=${WEPLAY_ROM:-"/usr/src/game-data"}

bad_selection() {
    echo 'Bad GAME selection, please try another one!'
    exit 1
}

export DN_SERVER=${DN_SERVER:-http://imdjh-dn.daoapp.io}

if [ ! -z "${GAME}" ];then
    echo "Fetching game..."
    curl -fsSL ${DN_SERVER}/${GAME} -o ${WEPLAY_ROM} || bad_selection
    file ${WEPLAY_ROM} > /var/tmp/game-data.filetype
    if ( $(grep -qi html /var/tmp/game-data.filetype) );then
        bad_selection
    fi
fi

if [[ -n "${REDIS_PORT}" ]];then
    export WEPLAY_REDIS_URI=${REDIS_PORT_6379_TCP_ADDR}:${REDIS_PORT_6379_TCP_PORT}
    export WEPLAY_REDIS_AUTH=${REDIS_PASSWORD}
else
    echo "Redis setting not found, can't start server." >&2 && exit 1
fi

forever /srv/weplay-emu/index.js 
