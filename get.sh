#
# Downloads the installer and installs into your computer
#
# The MIT License (MIT)
# Copyright (c) 2015 GochoMugo <mugo@forfuture.co.ke>
#


DIRNAME=moz-sdk


echo "⇒ cloning the installer's repo"
git clone https://github.com/GochoMugo/moz-addon-sdk-installer.git $DIRNAME


echo "⇒ moving installer to /usr/local/lib (requires  \"sudo\" powers)"
sudo rm -rf /usr/local/lib/$DIRNAME
sudo mv $DIRNAME /usr/local/lib


echo "⇒ adding the command (requires  \"sudo\" powers): moz-sdk"
sudo ln -sf /usr/local/lib/$DIRNAME/installer.sh /usr/local/bin/moz-sdk

