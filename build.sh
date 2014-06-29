#!/bin/sh
set -ex
VER='0.10.29'
URL="http://nodejs.org/dist/v$VER/node-v$VER-linux-x64.tar.gz"
F=$(basename $URL)

if [ "x$DOCKERUSER" = "x" ]; then
	echo "Use: export DOCKERUSER='<username>'"
	exit 1
fi

if [ ! -f $F ]; then
	wget $URL
fi

DIR=$(echo $F | sed 's|\.tar\.gz||')
if [ ! -d node-bin ]; then
	tar xf $F
	mv $DIR node-bin
fi

#OPT="--no-cache"
docker build $OPT -t $DOCKERUSER/node:$VER .
