FROM alpine:3.14

RUN apk update
RUN apk add git vim=8.2.2956-r0

WORKDIR /root/.vim/pack/plugins/start
COPY .tools/vimwiki ./vimwiki

COPY entrypoint.sh /entrypoint.sh

WORKDIR /root
COPY vimrc .vimrc

ENTRYPOINT ["/entrypoint.sh"]
