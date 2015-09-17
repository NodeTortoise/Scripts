#!/bin/bash

# DEFINE VARIABLES
NODE_PKG="nodejs-legacy"
NPM_PKG="npm"
GIT_PKG="git"
NODETORTOISE_REPOSITORY="https://github.com/oscarmartinezm/NodeTortoise.git"

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

echo "===> 1. Instalando NodeJS"
if ! isPackageInstalled $NODE_PKG; then
    apt-get install $NODE_PKG
fi

echo "===> 2. Instalando NodeJS Package Manager"
if ! isPackageInstalled $NPM_PKG; then
    apt-get install $NPM_PKG
fi

echo "===> 3. Instalando GIT"
if ! isPackageInstalled $GIT_PKG; then
    apt-get install $GIT_PKG
fi

echo "===> 4. Instalando NodeJS Forever"
npm install -g forever

echo "===> 5. Obteniendo repositorio de NodeTortoise en GitHub"
git clone $NODETORTOISE_REPOSITORY
cd NodeTortoise
npm install

echo "===> 6. Definiendo parametros de la aplicacion"
export PORT=80
export NODE_ENV=production
echo export NODE_ENV=production >> ~/.bash_profile
echo export PORT=80 >> ~/.bash_profile
#echo forever start bin/www >> ~/.bash_profile


echo "******************************"
echo "*****  Proceso Completo  *****"
echo "******************************"
