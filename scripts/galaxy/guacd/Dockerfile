
# Use alphine as base for running image
ARG ALPINE_VERSION=3.12
FROM alpine:${ALPINE_VERSION}

MAINTAINER calvin <c6supper@hotmail.com>

ENV GALAXY_DIR /galaxy
ENV GALAXY_INITIALIZED_MARK $GALAXY_DIR/patched
RUN mkdir -p $GALAXY_DIR
COPY ./version $GALAXY_DIR/version
COPY ./docker-entrypoint.sh /galaxy/docker-entrypoint.sh

# Update git tags here for new releases
ENV GUACD_VERSION      1.1.0
#ENV PULSEAUDIO_VERSION HEAD
ENV CXX='gcc'
ENV GUACD_LOG_LEVEL=info

RUN  sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories                  && \
     apk add --update --no-cache                                                                      \
        cairo                                                                                         \
        libjpeg-turbo                                                                                 \
        libpng                                                                                        \
        pango                                                                                         \
        libssh2                                                                                       \
        libvncserver                                                                                  \
        openssl                                                                                       \
        libvorbis                                                                                     \
        libwebp                                                                                       \
        libsndfile                                                                                    \
        pulseaudio                                                                                    \
        libusb                                                                                        \
        freerdp                                                                                       \
        ffmpeg-libs                                                                                   \
        libwebsockets                                                                              && \
     apk add --update --no-cache --virtual .build-deps                                                \
        git                                                                                           \
        make                                                                                          \
        automake                                                                                      \
        autoconf                                                                                      \
        cmake                                                                                         \
        gcc                                                                                           \
        libtool                                                                                       \
        build-base                                                                                    \
        linux-headers                                                                                 \
        bsd-compat-headers                                                                            \
        intltool                                                                                      \
        musl-dev                                                                                      \
        cairo-dev                                                                                     \
        libjpeg-turbo-dev                                                                             \
        libpng-dev                                                                                    \
        pango-dev                                                                                     \
        libssh2-dev                                                                                   \
        libvncserver-dev                                                                              \
        openssl-dev                                                                                   \
        libvorbis-dev                                                                                 \
        libwebp-dev                                                                                   \
        libsndfile-dev                                                                                \
        pulseaudio-dev                                                                                \
        libusb-dev                                                                                    \
        freerdp-dev                                                                                   \
        ffmpeg-dev                                                                                    \
        libwebsockets-dev                                                                          && \
     mkdir /tmp/build                                                                              && \
     cd /tmp/build                                                                                 && \
     git clone https://github.com/sean-/ossp-uuid.git                                              && \
     cd ossp-uuid                                                                                  && \
     ./configure                                                                                   && \
     make -j4                                                                                      && \
     make install                                                                                  && \
     cd ..                                                                                         && \
     ln -s /usr/local/lib/libuuid.so.16.0.22 /lib/libossp-uuid.so                                  && \
     git clone --branch 0.23 https://github.com/seanmiddleditch/libtelnet.git                      && \
     cd libtelnet                                                                                  && \
     autoreconf -i                                                                                 && \
     autoconf                                                                                      && \
     ./configure                                                                                   && \
     make -j4                                                                                      && \
     make install                                                                                  && \
     cd ..                                                                                         && \
     git clone --branch $GUACD_VERSION https://github.com/apache/guacamole-server.git              && \
     cd guacamole-server                                                                           && \
     autoreconf -i                                                                                 && \
     autoconf                                                                                      && \
     ./configure                                                                                   && \
     make -j4                                                                                      && \
     make install                                                                                  && \
     cd ..                                                                                         && \
     apk del .build-deps                                                                           && \
     rm -Rf /tmp/build                                                                             && \
     rm -f /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*                               && \
     mkdir -p /usr/share/fonts/TTF

COPY LiberationMono-Regular.ttf /usr/share/fonts/TTF/

EXPOSE 4822

ENTRYPOINT ["/galaxy/docker-entrypoint.sh"]

CMD ["/usr/local/sbin/guacd -b 0.0.0.0 -L $GUACD_LOG_LEVEL -f"]