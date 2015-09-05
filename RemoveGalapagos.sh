#!/bin/bash

# DEFINE VARIABLES
NODE_PKG="node"
NPM_PKG="npm"
GIT_PKG="git"
UNZIP_PKG="unzip"
IMAGEMAGICK_PKG="imagemagick"
OPENJDK_PKG="java-1.8.0-openjdk"
ORACLEJDK_PKG="oracle-java8-removeer"

# FUNCION QUE VERIFICA SI UN PAQUETE ESTE INSTALADO
isPackageInstalled() {
    if dpkg --get-selections | grep -q "^$1[[:space:]]*remove$" >/dev/null; 
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

#echo "1. Desinstalando "
#echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
#sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
#sudo apt-get update
#sudo apt-get remove sbt

echo "1. Desinstalando NodeJS"
if isPackageInstalled $NODE_PKG; then 
    apt-get remove $NODE_PKG
fi

echo "2. Desinstalando NodeJS Package Manager"
if isPackageInstalled $NPM_PKG; then 
    apt-get remove $NPM_PKG
fi

echo "2. Desinstalando GIT"
if isPackageInstalled $GIT_PKG; then 
    apt-get remove $GIT_PKG
fi

echo "2. Desinstalando UnZip"
if isPackageInstalled $UNZIP_PKG; then 
    apt-get remove $UNZIP_PKG
fi

echo "3. Desinstalando ImageMagick"
if isPackageInstalled $IMAGEMAGICK_PKG; then 
    apt-get remove $IMAGEMAGICK_PKG
fi

echo "5. Desinstalando Oracle Java 8 JDK"
if isPackageInstalled $ORACLEJDK_PKG; then 
    apt-get remove $ORACLEJDK_PKG
fi

echo "4. Instalando OpenJDK"
if ! isPackageInstalled $OPENJDK_PKG; then 
    apt-get install default-jdk
fi

#echo "5. Desinstalando Play Framework"
#wget http://downloads.typesafe.com/typesafe-activator/1.3.5/typesafe-activator-1.3.5-minimal.zip
#unzip typesafe-activator-1.3.5-minimal.zip

#echo "5. Obteniendo repositorio de Galapagos en GitHub"
#git clone https://github.com/NetLogo/Galapagos.git
#cd Galapagos
#ln -s start ../activator-1.3.5-minimal/activator

echo "******************************"
echo "*****  Proceso Completo  *****"
echo "******************************"
