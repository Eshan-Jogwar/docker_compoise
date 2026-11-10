FROM alpine:3.21

ARG TARGETARCH=amd64
ARG RELEASE=RELEASE.2025-04-22T22-12-26Z

RUN apk add --no-cache ca-certificates curl bash && \
    ARCH="${TARGETARCH:-amd64}" && \
    curl -sSL "https://github.com/minio/minio/releases/download/${RELEASE}/minio.linux-${ARCH}.${RELEASE}" -o /usr/bin/minio && \
    chmod +x /usr/bin/minio && \
    mkdir -p /data

COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/docker-entrypoint.sh

EXPOSE 9000 9001
VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
CMD ["minio"]
