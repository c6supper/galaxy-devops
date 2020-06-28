
# Use alphine as base for the build
ARG ALPINE_VERSION=3.12
FROM alpine:${ALPINE_VERSION} AS builder

MAINTAINER calvin <c6supper@hotmail.com>

# Base directory for installed build artifacts.
# Due to limitations of the Docker image build process, this value is
# duplicated in an ARG in the second stage of the build.
#
ARG PREFIX_DIR=/usr

# Build arguments
ARG BUILD_DIR=/tmp/nginx-BUILD

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --update openssl-dev pcre-dev zlib-dev libxslt-dev \
    gd-dev geoip-dev linux-pam-dev expat-dev build-base bash && \
    apk add --virtual temppkg &&  \
    apk del temppkg && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Copy source to container for sake of build
COPY nginx "$BUILD_DIR"

# Build guacamole-server from local source
RUN set -ex \
    && cd "$BUILD_DIR"/nginx-release-1.19.0 \
    && ./configure --with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2' \
    --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now' \
    --prefix=/usr --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock \
    --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body \
    --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy \
    --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
    --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module \
    --with-http_realip_module --with-http_auth_request_module --with-http_addition_module \
    --with-http_dav_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module \
    --with-http_image_filter_module --with-http_v2_module --with-http_sub_module --with-http_xslt_module \
    --with-stream --with-stream_ssl_module --with-mail --with-mail_ssl_module --with-threads \
    --add-module=../ngx_http_auth_pam_module --add-module=../nginx-dav-ext-module \
    --add-module=../echo-nginx-module --add-module=../nginx-upstream-fair \
    --add-module=../ngx_http_substitutions_filter_module \
    --add-module=../ngx_devel_kit \
    --add-module=../set-misc-nginx-module --with-stream_ssl_preread_module \
    && make -j4 && make install

# Use same alpine as the base for the runtime image
FROM alpine:${ALPINE_VERSION}

# Base directory for installed build artifacts.
# Due to limitations of the Docker image build process, this value is
# duplicated in an ARG in the first stage of the build. See also the
# CMD directive at the end of this build stage.
#
ARG PREFIX_DIR=/usr

ENV GALAXY_DIR /galaxy
ENV GALAXY_INITIALIZED_MARK $GALAXY_DIR/patched
RUN mkdir -p $GALAXY_DIR
COPY ./version $GALAXY_DIR/version
COPY ./docker-entrypoint.sh /galaxy/docker-entrypoint.sh
ENV GALAXY_CLIENT_HOST galaxy-client
ENV GALAXY_TUNNEL_HOST galaxy-tunnel

# Copy build artifacts into this stage
COPY --from=builder ${PREFIX_DIR}/sbin/nginx ${PREFIX_DIR}/sbin/nginx
COPY etc "/etc"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --update openssl pcre zlib libxslt \
    gd geoip linux-pam expat bash gettext && \
    apk add --virtual temppkg &&  \
    apk del temppkg && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# initilization for the first time
ENTRYPOINT ["/galaxy/docker-entrypoint.sh"]

STOPSIGNAL SIGTERM

# Expose the default listener port
EXPOSE 80 443

CMD ["nginx"]