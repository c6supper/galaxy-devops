
# Use Debian as base for the build
ARG DEBIAN_VERSION=stable
FROM debian:${DEBIAN_VERSION} AS builder

# Base directory for installed build artifacts.
# Due to limitations of the Docker image build process, this value is
# duplicated in an ARG in the second stage of the build.
#
ARG PREFIX_DIR=/usr

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list;

# Build arguments
ARG BUILD_DIR=/tmp/nginx-BUILD
ARG BUILD_DEPENDENCIES="    \
        libpcre3-dev    \
        libssl-dev      \
        libxslt1-dev    \
        libgd-dev       \
        libgeoip-dev    \
        libpam0g-dev    \
        gcc make"

# Bring build environment up to date and install build dependencies
RUN apt-get update                         && \
    apt-get install -y $BUILD_DEPENDENCIES && \
    rm -rf /var/lib/apt/lists/*

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

# Use same Debian as the base for the runtime image
FROM debian:${DEBIAN_VERSION}-slim

# Base directory for installed build artifacts.
# Due to limitations of the Docker image build process, this value is
# duplicated in an ARG in the first stage of the build. See also the
# CMD directive at the end of this build stage.
#
ARG PREFIX_DIR=/usr

ARG RUNTIME_DEPENDENCIES=" \
        libpcre3 \
        libssl1.1 \
        libxslt1.1 \
        libgd3 \
        libgeoip1 \
        libpam0g"

# Copy build artifacts into this stage
COPY --from=builder ${PREFIX_DIR}/sbin/nginx ${PREFIX_DIR}/sbin/nginx
COPY etc "/etc"

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list;
# Bring runtime environment up to date and install runtime dependencies
RUN apt-get update                                          && \
    apt-get install -y $RUNTIME_DEPENDENCIES                && \
    apt-get install -y $(cat "${PREFIX_DIR}"/DEPENDENCIES)  && \
    rm -rf /var/lib/apt/lists/*                             && \
    mkdir -p /var/log/nginx/                                && \
    mkdir -p /var/lib/nginx/body

# Expose the default listener port
EXPOSE 80 443
