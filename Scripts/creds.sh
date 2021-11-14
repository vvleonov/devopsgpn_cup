#!/bin/bash


# Configuring Jenkins credentials

set -e


/etc/init.d/jenkins stop
echo "Jenkins is stopped"


if [ -e "identity.key.enc" ]; then
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


CREDS=`find "$(cd ..; pwd)" -name "credentials.tgz"`
if [ -e "$CREDS" ]; then
    cp "$CREDS" /var/lib/jenkins
    tar xzvf /var/lib/jenkins/credentials.tgz -C /var/lib/jenkins
    echo "All done"
else
    echo "Can't see the credentials archive"
fi

/etc/init.d/jenkins start
echo "Jenkins is started"

