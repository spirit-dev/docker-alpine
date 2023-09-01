FROM scratch

ARG alpine_version

LABEL alpine_version="${alpine_version}" \
      spiritdev_official="yes" \
      layer="0" \
      from="scratch" \
      maintainer="bordat.jean@gmail.com"

ENV ENV=/root/.profile

ADD assets/alpine-minirootfs-${alpine_version}-x86_64.tar.gz /

RUN apk add --no-cache bash curl bind-tools

CMD ["/bin/sh"]

COPY assets/.profile /root/.profile
COPY assets/.profile /root/.bashrc
