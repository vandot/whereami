FROM vandot/alpine-bash

LABEL maintainer "ivan@vandot.rs"

COPY whereami.sh bashclient.sh /

ENTRYPOINT ["bash", "/whereami.sh"]