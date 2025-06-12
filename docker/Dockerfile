FROM scratch

ARG alpine_version git_hash \
    build_date \
    architecture

LABEL alpine_version="${alpine_version}" \
      spiritdev_official="yes" \
      layer="0" \
      from="scratch" \
      maintainer="bordat.jean@gmail.com"

ENV ENV=/root/.profile \
    BUILD_HASH=${git_hash} \
    BUILD_DATE=${build_date}

ADD docker/assets/alpine-minirootfs-${alpine_version}-${architecture}.tar.gz /

RUN apk add --no-cache bash curl bind-tools

CMD ["/bin/bash"]

COPY docker/assets/.profile /root/.profile
COPY docker/assets/.profile /root/.bashrc
