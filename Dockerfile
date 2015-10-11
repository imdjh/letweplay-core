FROM node:0.10
MAINTAINER Jiahao Dai<dyejarhoo@gmail.com>

RUN git clone https://github.com/rauchg/weplay-emulator /srv/weplay-emu && \
        cd /srv/weplay-emu && \
        npm install && \
        npm install -g forever

EXPOSE 8000  # daocloud MAGIC

COPY docker-entrypoint.sh /entrypoint.sh
CMD ["entrypoint.sh"]
