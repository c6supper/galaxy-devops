# Use same alphine as the base for the runtime image
FROM alpine:3.12

MAINTAINER calvin <c6supper@hotmail.com>

ENV GALAXY_DIR /galaxy
ENV GALAXY_INITIALIZED_MARK $GALAXY_DIR/patched
RUN mkdir -p $GALAXY_DIR
COPY ./version $GALAXY_DIR/version
COPY ./docker-entrypoint.sh /galaxy/docker-entrypoint.sh

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --update openvpn bc grep bash && \
    apk add --virtual temppkg &&  \
    apk del temppkg && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Add configuration scripts
COPY ./etc/openvpn "/etc/openvpn"

ENV OPENVPN_DIR /etc/openvpn
ENV OVPN_CONFIG $OPENVPN_DIR/server.conf
# default configuration for openvpn
ENV OVPN_PORT   1194
ENV OVPN_PROTO  tcp
ENV OVPN_TLS_AUTH ta.key
ENV OVPN_IP_POOL  10.0.0.0
ENV OVPN_CA ca.crt
ENV OVPN_CERT server1.crt
ENV OVPN_KEY server1.key
# default configuration for istio
ENV RUN_AFTER_SIDECAR yes

# initilization for the first time
ENTRYPOINT ["/galaxy/docker-entrypoint.sh"]

EXPOSE 1194/tcp 1195/udp 1196/udp

CMD ["openvpn --cd $OPENVPN_DIR --config $OVPN_CONFIG 2>&1"]
