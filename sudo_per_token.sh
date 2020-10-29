#!/bin/sh
# This script sets a debian box to use a plugged in security token to
# secure sudo

if [ -e $1 ]; then
    USER=`id -u -n`
else
    USER=$1
fi

while true; do
read -p "Do you want to set the token as required for user \"$USER\" to use sudo? (y/n)" yn
case $yn in
    [yY]* ) break;;
    [nN]* ) exit 0
            break;;
    * ) echo "Please anser y or n ";;
esac
done

sudo apt-get install libpam-poldi
APPID=`gpg --card-status | grep "Application ID" | grep -o -E -e '[^ ]*$'`
echo $APPID $USER | sudo tee -a /etc/poldi/localdb/users
#sudo "gpg-connect-agent \"/datafile /etc/poldi/localdb/keys/$APPID\" \"SCD READKEY --advanced OPENPGP.3\" /bye"


gpg-connect-agent "/datafile /tmp/$APPID" "SCD READKEY --advanced OPENPGP.3" /bye
sudo mv /tmp/$APPID /etc/poldi/localdb/keys/$APPID


echo "auth required pam_poldi.so" | sudo tee /etc/pam.d/sudo_tmp
cat /etc/pam.d/sudo | sudo tee -a /etc/pam.d/sudo_tmp
sudo mv /etc/pam.d/sudo_tmp /etc/pam.d/sudo
