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
$OVPN_INITIALIZED_MARK
EOF
}

if ! grep -q $OVPN_INITIALIZED_MARK "$OVPN_CONFIG"; then
  patch_conf
  echo
  echo 'openvpn init process complete; ready for start up.'
  echo
else
  echo
  echo 'Skipping initialization'
  echo
fi

/bin/sh -c "$@"
