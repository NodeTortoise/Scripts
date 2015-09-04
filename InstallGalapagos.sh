#!/bin/bash

# DEFINE VARIABLES
GIT_PKG="git"

echo "Instalando Galapagos...."

#echo "1. Instalando "
#echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
#sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
#sudo apt-get update
#sudo apt-get install sbt

echo "2. Instalando NodeJS...."
apt-get install node
apt-get install npm

echo "3. Instalando GIT"
if dpkg --get-selections | grep -q "^$GIT_PKG[[:space:]]*install$" >/dev/null; then

#apt-get install git
#apt-get install unzip
#wget http://downloads.typesafe.com/typesafe-activator/1.3.5/typesafe-activator-1.3.5-minimal.zip
#unzip typesafe-activator-1.3.5-minimal.zip
#ln -s start ../activator-1.3.5-minimal/activator

#apt-get purge openjdk*

#add-apt-repository ppa:webupd8team/java
#apt-get update
#apt-get install oracle-java8-installer

#apt-get install imagemagick


# SET VARIABLES
#JS_FILES=(/home/ubuntu/TFIA/NodeJS/model/js.custom/_constants.js)
#IP_ADDRESS="$(wget -qO- http://ipecho.net/plain ; echo)"

#echo "Done!"
