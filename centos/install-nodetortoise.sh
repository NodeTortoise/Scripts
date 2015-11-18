#!/bin/bash

# DEFINE VARIABLES
NODE_PKG="nodejs"
GIT_PKG="git"
NODETORTOISE_REPOSITORY="https://github.com/oscarmartinezm/NodeTortoise.git"

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

echo "===> 3. Instalando NodeJS Forever"
npm install -g forever

echo "===> 4. Obteniendo repositorio de NodeTortoise en GitHub"
rm -rf NodeTortoise
git clone $NODETORTOISE_REPOSITORY
cd NodeTortoise
npm install

echo "******************************"
echo "*****  Proceso Completo  *****"
echo "******************************"