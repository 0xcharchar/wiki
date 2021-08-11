FROM alpine:3.14

RUN apk update
RUN apk add git vim=8.2.2956-r0

RUN mkdir -p /usr/share/vim/vim82/pack/wiki/start
RUN git clone https://github.com/vimwiki/vimwiki.git --branch v2.5 --depth 1 /usr/share/vim/vim82/pack/wiki/start/vimwiki

COPY entrypoint.sh /entrypoint.sh

COPY vimrc /etc/vim/vimrc

ENTRYPOINT ["/entrypoint.sh"]
