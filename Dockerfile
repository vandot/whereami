FROM vandot/alpine-bash

LABEL maintainer "ivan@vandot.rs"

COPY whereami.sh bashclient /

ENTRYPOINT ["bash", "/whereami.sh"]
