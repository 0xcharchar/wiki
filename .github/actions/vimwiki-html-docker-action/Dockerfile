FROM pandoc/core:2.14.1

RUN apk update && apk add make

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
