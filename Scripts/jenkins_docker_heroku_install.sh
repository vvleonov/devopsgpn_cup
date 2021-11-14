#!/bin/bash

# Java and Jenkins installation

apt update

apt install -y openjdk-11-jdk snapd

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    
apt update
apt install -y jenkins
echo "Jenkins is installed"


# Docker installation

apt install -y ca-certificates \
	    curl \
	    gnupg \
	    lsb-release \

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg  

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    
apt update
apt install -y docker-ce docker-ce-cli containerd.io
echo "Docker is installed"

usermod -aG docker jenkins

snap install --classic heroku

