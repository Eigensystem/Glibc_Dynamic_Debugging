#!/bin/bash
echo -e "\033[32m[*]Usage : change.sh ld_version filename\033[0m"
FOLDER=$(cd "$(dirname "$0")";pwd)
LDD=$(ldd $2 | awk '{print $1}' | sed -n '2p')	
#seccomp checking
if test $LDD = "libseccomp.so.2"; then
	LDD=$(ldd $2 | awk '{print $1}' | sed -n '3p')	
fi
sudo patchelf --set-interpreter $FOLDER/$1/ld-$1.so --set-rpath $FOLDER/$1 $(pwd)/$2
sudo patchelf --replace-needed  $LDD  $FOLDER/$1/libc-$1.so $(pwd)/$2
