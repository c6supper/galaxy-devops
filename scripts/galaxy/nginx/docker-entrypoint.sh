#!/bin/sh

set -ex

patch_conf() {
  defined_envs=$(printf '${%s} ' $(env | cut -d= -f1))
  envsubst "$defined_envs" < "/etc/nginx/conf.d/server.conf.template" > "/etc/nginx/conf.d/server.conf"
}

if [ ! -f "$GALAXY_INITIALIZED_MARK" ]; then
  patch_conf
  mkdir -p /var/lib/nginx/body
  touch $GALAXY_INITIALIZED_MARK
  apk del gettext
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*
  echo
  echo 'openvpn init process complete; ready for start up.'
  echo
else
  echo
  echo 'Skipping initialization'
  echo
fi

/bin/sh -c "$@"
