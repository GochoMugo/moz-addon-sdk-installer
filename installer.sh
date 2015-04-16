#
# Installs or Updates The Addon SDK
#
# The MIT License (MIT)
# Copyright (c) 2015 GochoMugo <mugo@forfuture.co.ke>
#


# we need some utilities
source utils.sh


# script variables
LOG_TITLE="moz-addon-sdk-installer"


# check if we are supposed to self-update
if [ ${1} ] ; then
  if [ ${1} == "-u" ] ; then
    log "self-update started" 0
    wget -qO- http://git.io/vvEpZ | bash
  fi
fi


log "changing to /tmp" 0
ORIG_DIR="$PWD"
cd /tmp
rm -rf cfx.zip temp cfx
mkdir temp cfx


log "downloading zipfile with sdk" 0
wget -q -O cfx.zip https://ftp.mozilla.org/pub/mozilla.org/labs/jetpack/jetpack-sdk-latest.zip


log "unzipping zipfile" 0
unzip -q cfx.zip -d temp
cp -r temp/*/. cfx


log "installing (requires \"sudo\" powers)" 0
sudo rm -rf /usr/local/lib/cfx
sudo mv cfx /usr/local/lib/
sudo ln -sf /usr/local/lib/cfx/bin/cfx /usr/local/bin/cfx


log "cleaning up" 0
rm -rf cfx.zip temp


log "changing to previous directory" 0
cd $ORIG_DIR


log "installed successfully: $(cfx --version)" 1
log "addon sdk available with the command: cfx" 1

