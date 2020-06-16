# Use Debian as base for the build
ARG DEBIAN_VERSION=stable
# Use same Debian as the base for the runtime image
FROM debian:${DEBIAN_VERSION}-slim

ARG RUNTIME_DEPENDENCIES="            \
        openvpn"

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list;
# Bring runtime environment up to date and install runtime dependencies
RUN apt-get update                                          && \
    apt-get install -y $RUNTIME_DEPENDENCIES                && \
    apt-get install -y $(cat "${PREFIX_DIR}"/DEPENDENCIES)  && \
    rm -rf /var/lib/apt/lists/*

#RUN mkdir -p /var/run/sshd \
#    && echo 'root:123' | chpasswd \
#    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
#    # SSH login fix. Otherwise user is kicked off after login
#    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
#    && echo "export VISIBLE=now" >> /etc/profile

# Add configuration scripts
COPY etc "/etc"

STOPSIGNAL SIGTERM
#

