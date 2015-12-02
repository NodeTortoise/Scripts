#!/bin/bash

# CONFIGURATION
INSTALL_LOCATION="/home/ubuntu"

# DEFINE VARIABLES
SBT_PKG="sbt"
NODE_PKG="nodejs-legacy"
NPM_PKG="npm"
GIT_PKG="git"
UNZIP_PKG="unzip"
IMAGEMAGICK_PKG="imagemagick"
OPENJDK_PKG="openjdk"
ORACLEJDK_PKG="oracle-java8-installer"

# FUNCION QUE VERIFICA SI UN PAQUETE ESTE INSTALADO
isPackageInstalled() {
    if dpkg --get-selections | grep -q "^$1[[:space:]]*install$" >/dev/null;
    then
        echo "$1 previamente instalado"
        return 0 # 0 = true
    else
        return 1 # 1 = false
    fi
}

# INICIA LOGICA

echo "******************************"
echo "******  Inicia Proceso  ******"
echo "******************************"

echo "===> 1. Actualizando lista de paquetes"
apt-get update

echo "===> 2. Instalando NodeJS"
if ! isPackageInstalled $NODE_PKG; then
    apt-get --yes --force-yes install $NODE_PKG
fi

echo "===> 3. Instalando NodeJS Package Manager"
if ! isPackageInstalled $NPM_PKG; then
    apt-get --yes --force-yes install $NPM_PKG
fi

echo "===> 4. Instalando SBT"
if ! isPackageInstalled $SBT_PKG; then
    echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
    apt-get update
    apt-get --yes --force-yes install $SBT_PKG
fi

echo "===> 5. Instalando GIT"
if ! isPackageInstalled $GIT_PKG; then
    apt-get --yes --force-yes install $GIT_PKG
fi

echo "===> 6. Instalando UnZip"
if ! isPackageInstalled $UNZIP_PKG; then
    apt-get --yes --force-yes install $UNZIP_PKG
fi

echo "===> 7. Desinstalando OpenJDK"
if isPackageInstalled $OPENJDK_PKG; then
    apt-get purge $OPENJDK_PKG*
fi

echo "===> 8. Instalando Oracle Java 8 JDK"
if ! isPackageInstalled $ORACLEJDK_PKG; then
    add-apt-repository ppa:webupd8team/java
    apt-get update
    apt-get --yes --force-yes install $ORACLEJDK_PKG
fi

echo "===> 9. Instalando Play Framework"
wget http://downloads.typesafe.com/typesafe-activator/1.3.5/typesafe-activator-1.3.5-minimal.zip
unzip typesafe-activator-1.3.5-minimal.zip
rm typesafe-activator-1.3.5-minimal.zip

echo "===> 10. Obteniendo repositorio de Galapagos en GitHub"
cd $INSTALL_LOCATION
git clone https://github.com/oscarmartinezm/Galapagos.git
cd Galapagos
ln -s ../activator-1.3.5-minimal/activator play
chmod 777 run.sh

echo "******************************"
echo "*****  Proceso Completo  *****"
echo "******************************"
