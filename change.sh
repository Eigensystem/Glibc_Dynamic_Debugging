#!/bin/bash
FOLDER=$(cd "$(dirname "$0")";pwd)
if [ $# -eq 2 ]; then
	echo -e "\033[32m[*]Usage : change.sh ld_version filename\033[0m"
	LDD=$(ldd $2 | awk '{print $1}' | sed -n '2p')	
	#seccomp checking
	if test $LDD = "libseccomp.so.2"; then
		LDD=$(ldd $2 | awk '{print $1}' | sed -n '3p')	
	fi
	sudo patchelf --set-interpreter $FOLDER/$1/amd64/ld-$1.so --set-rpath $FOLDER/$1/amd64 $(pwd)/$2
	sudo patchelf --replace-needed  $LDD  $FOLDER/$1/amd64/libc-$1.so $(pwd)/$2
elif [ $# -eq 3 ];then
	echo -e "\033[32m[*]Usage : change.sh ld_version architecture(amd64/i386) filename\033[0m"
	LDD=$(ldd $3 | awk '{print $1}' | sed -n '2p')	
	#seccomp checking
	if test $LDD = "libseccomp.so.2"; then
		LDD=$(ldd $3 | awk '{print $1}' | sed -n '3p')	
	fi
	
	if test $2 = "amd64"; then
		sudo patchelf --set-interpreter $FOLDER/$1/amd64/ld-$1.so --set-rpath $FOLDER/$1/amd64 $(pwd)/$3
		sudo patchelf --replace-needed  $LDD  $FOLDER/$1/amd64/libc-$1.so $(pwd)/$3
	elif test $2 = "i386"; then
		sudo patchelf --set-interpreter $FOLDER/$1/i386/ld-$1.so --set-rpath $FOLDER/$1/i386 $(pwd)/$3
		sudo patchelf --replace-needed  $LDD  $FOLDER/$1/i386/libc-$1.so $(pwd)/$3
	else
		echo -e "\033[31m[!]No such architecture!\033[0m"
	fi
else
	echo -e "\033[31m[!]Only 2 or 3 arguments available.\033[0m"
fi
