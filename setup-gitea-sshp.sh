#!/bin/bash
if ! id git &>/dev/null ; then
    echo "User 'git' doesn't exist. Aborting."
    exit 1
fi

if [[ $EUID -ne `id git` ]]; then
   echo "This script must be run as 'git'. Aborting."
   exit 1
fi

echo "Generating SSH key."
ssh-keygen -t rsa -b 4096 -C "Gitea Host Key" >> /dev/null

echo "Adding key to authorized keys."
mkdir -p ~git/.ssh
cat ~git/.ssh/id_rsa.pub >> ~git/.ssh/authorized_keys
chmod 0600 ~git/.ssh/authorized_keys

echo "Setting shell to restricted shell."
chsh -s ~git/bin/gitea-shell git

echo "Downloading scripts."
mkdir -p ~git/.bin
wget -qO ~git/.bin/gitea https://raw.githubusercontent.com/hadi77ir/gitea-ssh-passthrough/main/gitea
wget -qO ~git/.bin/gitea-shell https://raw.githubusercontent.com/hadi77ir/gitea-ssh-passthrough/main/gitea-shell

echo "Setting permissions."
chmod +x ~git/.bin/gitea
chmod +x ~git/.bin/gitea-shell

echo "Done."