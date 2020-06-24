#!/bin/sh

set -ex

patch_conf() {
cat >> $OVPN_CONFIG <<EOF
proto $OVPN_PROTO
port $OVPN_PORT
tls-auth $OVPN_TLS_AUTH 0
server $OVPN_IP_POOL 255.255.255.0 nopool
ca $OVPN_CA
cert $OVPN_CERT
key $OVPN_KEY
EOF
}

if [ ! -f "$GALAXY_INITIALIZED_MARK" ]; then
  patch_conf
  touch $GALAXY_INITIALIZED_MARK
  echo
  echo 'openvpn init process complete; ready for start up.'
  echo
else
  echo
  echo 'Skipping initialization'
  echo
fi

/bin/sh -c "$@"
