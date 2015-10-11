FROM node:0.10
MAINTAINER Jiahao Dai<dyejarhoo@gmail.com>

RUN git clone https://github.com/rauchg/weplay-emulator /srv/weplay-emu && \
        cd /srv/weplay-emu && \
        npm install && \
        npm install -g forever

# daocloud MAGIC
EXPOSE 8000

COPY docker-entrypoint.sh /entrypoint.sh
CMD ["entrypoint.sh"]
