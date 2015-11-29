#!/bin/bash

# CONFIGURATION
INSTALL_LOCATION="/home/ubuntu"
CONFIG_FILE_LOCATION="config/public/main.js"
NODETORTOISE_REPOSITORY="https://github.com/oscarmartinezm/NodeTortoise.git"

# DEFINE VARIABLES
NODE_PKG="nodejs-legacy"
NPM_PKG="npm"
GIT_PKG="git"
IP_ADDRESS="$(wget -qO- http://ipecho.net/plain ; echo)"

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
    apt-get install $NODE_PKG
fi

echo "===> 3. Instalando NodeJS Package Manager"
if ! isPackageInstalled $NPM_PKG; then
    apt-get install $NPM_PKG
fi

echo "===> 4. Instalando GIT"
if ! isPackageInstalled $GIT_PKG; then
    apt-get install $GIT_PKG
fi

echo "===> 5. Instalando NodeJS Forever"
npm install -g forever

echo "===> 6. Obteniendo repositorio de NodeTortoise en GitHub"
cd $INSTALL_LOCATION
git clone $NODETORTOISE_REPOSITORY

echo "===> 7. Instalando NodeTortoise"
cd NodeTortoise
npm install
echo "var _ENVIRONMENT = ENVIRONMENT_DEVELOPMENT;" >> $CONFIG_FILE_LOCATION;
echo "var _SERVER = '$IP_ADDRESS';" >> $CONFIG_FILE_LOCATION;

echo "******************************"
echo "*****  Proceso Completo  *****"
echo "******************************"
