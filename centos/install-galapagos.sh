#!/bin/bash

# DEFINE VARIABLES
NODE_PKG="nodejs"
SBT_PKG="sbt"
GIT_PKG="git"
UNZIP_PKG="unzip"
WGET_PKG="wget"
OPENJDK_PKG="jdk1*"
ORACLEJDK_PKG="jdk1.8*"

# FUNCION QUE VERIFICA SI UN PAQUETE ESTE INSTALADO
isPackageInstalled() {
    if yum list installed "$@" >/dev/null	
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

echo "===> 1. Instalando NodeJS and NPM"
if ! isPackageInstalled $NODE_PKG; then    
	curl --silent --location https://rpm.nodesource.com/setup | bash -
    yum -y install $NODE_PKG
fi

echo "===> 2. Instalando GIT"
if ! isPackageInstalled $GIT_PKG; then
    yum install $GIT_PKG
fi

echo "===> 3. Instalando UnZip"
if ! isPackageInstalled $UNZIP_PKG; then
    yum install $UNZIP_PKG
fi

echo "===> 4. Desinstalando OpenJDK"
if isPackageInstalled $OPENJDK_PKG; then
    yum remove $OPENJDK_PKG
fi

echo "===> 5. Instalando wget"
if ! isPackageInstalled $WGET_PKG; then
    yum install $WGET_PKG
fi

echo "===> 6. Instalando Oracle Java 8 JDK"
if ! isPackageInstalled $ORACLEJDK_PKG; then
	cd ~
	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"	
	rpm -ivh jdk-8u60-linux-x64.rpm
fi

echo "===> 7. Instalando SBT"
if ! isPackageInstalled $SBT_PKG; then
    curl https://bintray.com/sbt/rpm/rpm | sudo tee /etc/yum.repos.d/bintray-sbt-rpm.repo
	sudo yum install $SBT_PKG
fi

echo "===> 8. Instalando Play Framework"
wget http://downloads.typesafe.com/typesafe-activator/1.3.5/typesafe-activator-1.3.5-minimal.zip
unzip typesafe-activator-1.3.5-minimal.zip
rm typesafe-activator-1.3.5-minimal.zip

echo "===> 9. Obteniendo repositorio de Galapagos en GitHub"
rm -rf Galapagos
git clone https://github.com/oscarmartinezm/Galapagos.git
cd Galapagos
ln -s ../activator-1.3.5-minimal/activator start

echo "******************************"
echo "*****  Proceso Completo  *****"
echo "******************************"