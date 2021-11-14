#!/bin/bash


# Configuring Jenkins credentials

set -e

apt-get install coreutils


/etc/init.d/jenkins stop
echo "Jenkins is stopped"


if [ -f "identity.key.enc" ]; then
    rm identity.key.enc
else
    echo "There is no identity key. Skipping"
fi


if [ -d "/var/lib/jenkins" ]; then
    echo "Looking for credentials"
else
    mkdir /var/lib/jenkins
    echo "The /var/lib/jenkins directory is created"
fi



if [ -f `readlink -f credentials.tgz` ]; then
    if [ -f "/var/lib/jenknins/credentials.tgz" ]; then
	cd /var/lib/jenkins
        tar xzvf ./credentials.tgz -C ./
        /etc/init.d/jenkins start
        echo "All done"
	exit 1
    else
	mv `readlink -f credentials.tgz` /var/lib/jenkins
        cd /var/lib/jenkins
        tar xzvf ./credentials.tgz -C ./
        /etc/init.d/jenkins start
        echo "All done"
	exit 1
    fi
else
    echo "Can't see the credentials archive. Do you run the script from 'Scripts' diretory?"
fi

