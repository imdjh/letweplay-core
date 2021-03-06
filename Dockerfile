FROM node:0.12
MAINTAINER Jiahao Dai<dyejarhoo@gmail.com>

RUN apt-get update && apt-get install -y \
        libcairo2-dev \
        libjpeg-dev \
        libgif-dev \
        libpango1.0-dev \
        && rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://github.com/imdjh/weplay-emulator /srv/weplay-emu && \
        cd /srv/weplay-emu && \
        npm install && \
        npm install -g forever

# daocloud MAGIC
EXPOSE 8000

ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
