#
# Downloads the installer and installs into your computer
#
# The MIT License (MIT)
# Copyright (c) 2015 GochoMugo <mugo@forfuture.co.ke>
#


CMDNAME=moz-sdk


echo "⇒ cloning the installer's repo"
git clone https://github.com/GochoMugo/moz-addon-sdk-installer.git $CMDNAME


echo "⇒ adding the command (requires  \"sudo\" powers): moz-sdk"
sudo mv $CMDNAME/installer.sh /usr/local/bin/moz-sdk


echo "⇒ cleaning up"
rm -rf $CMDNAME

