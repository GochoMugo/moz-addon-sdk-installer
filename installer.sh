#
# Installs or Updates The Addon SDK
#
# The MIT License (MIT)
# Copyright (c) 2015 GochoMugo <mugo@forfuture.co.ke>
#


# script variables
VERSION="0.0.1"
LOG_TITLE="moz-addon-sdk-installer"
# Colors for Bash
COLOR_BLUE="\033[0;34m"
COLOR_GREEN="\033[0;32m"
COLOR_RED="\033[0;31m"
COLOR_RESET="\e[0m"
COLOR_WHITE="\033[1;37m"


# logs to console
#
# ${1}  message to write to console
# ${2} what color to use. 0 - info(blue), 1- success(green),
#   2 - error(red)
# ${LOG_TITLE} for setting title of logging
log() {
  if [ ! ${2} -eq -1 ] ; then
    [ ${2} -eq 0 ] && local color=${COLOR_BLUE}
    [ ${2} -eq 1 ] && local color=${COLOR_GREEN}
    [ ${2} -eq 2 ] && local color=${COLOR_RED}
    echo -e "${COLOR_WHITE}${LOG_TITLE}: ${color}${1}${COLOR_RESET}"
  else
    echo "${1}"
  fi
}


# check if we are supposed to self-update
if [ ${1} ] ; then
  case ${1} in
    "-v" )
      echo
      command -v cfx > /dev/null 2>&1 \
        && echo "cfx: $(cfx --version)" \
        || echo -e "${COLOR_RED}Mozilla Addon SDK not installed${COLOR_RESET}"
      echo "moz-sdk: $VERSION"
      echo
      ;;
    "-u" )
      log "self-update started" 0
      rm -f .get
      wget -q http://git.io/vvEpZ -O .get
      [ $? -eq 0 ] || {
        echo -e "${COLOR_RED}failed to download updates${COLOR_RESET}"
        exit 1
      }
      cat .get | bash
      rm .get
      ;;
    "-h" )
      echo
      echo " $LOG_TITLE $VERSION by GochoMugo <mugo@forfuture.co.ke>"
      echo
      echo "    moz-sdk          installs/updates addon sdk"
      echo "    moz-sdk -u       updates this installer"
      echo "    moz-sdk -v       show version information"
      echo "    moz-sdk -h       show this help information"
      echo
      ;;
  esac
  exit
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
