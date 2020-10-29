# sudo_per_token
This script is used to setup a debian box to use a securecard to protect
sudo.

This is really rough. There is no errorhandling. The tokeen has to be
inserted. Only use this script once!

the following files will be added/altered
* /etc/poldi/localdb/keys/$APPID
* /etc/pam.d/sudo
* /etc/poldi/localdb/users

