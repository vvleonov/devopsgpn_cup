#!/bin/bash


# Configuring Jenkins credentials

set -e

/etc/init.d/jenkins stop
echo "Jenkins is stopped"

# [ -e identity.key.enc ] && rm identity.key.enc

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




if [ -f ../credentials/credentials.tgz ]; then
    mv ../credentials/credentials.tgz /var/lib/jenkins
    cd /var/lib/jenkins
    tar xzvf ./credentials.tgz -C ./
    /etc/init.d/jenkins start
    echo "All done"
else
    echo "Can't see the credentials archive. Do you run the script from 'Scripts' diretory?"
fi


# mv ../credentials/credentials.tgz /var/lib/jenkins
# cd /var/lib/jenkins 
# tar xzvf ./credentials.tgz -C ./
# /etc/init.d/jenkins start
