#!/bin/sh

set -ex

patch_conf() {
  echo 'Currently no configuration for guacd.'
}

if [ ! -f "$GALAXY_INITIALIZED_MARK" ]; then
  touch $GALAXY_INITIALIZED_MARK
  echo
  echo 'guacd init process complete; ready for start up.'
  echo
else
  echo
  echo 'Skipping initialization'
  echo
fi

/bin/sh -c "$@"
