#!/bin/bash

if [[ $# -ne 1 ]] ; then
	echo "Usage: upload.sh <tar file>"
	exit 1
fi

if ! [[ -f $1 ]] ; then
	echo "Can't find file $1"
	exit 1
fi

if ! gpg -u gpg@ghalkes.nl --detach-sig "$1" ; then
	echo "Failed to sign package"
	exit 1
fi

if ! scp -p "$1.sig" www.ghalkes.nl:os.ghalkes.nl/dist/ ; then
	echo "Failed to upload signature"
	exit 1
fi

if ! scp -p "$1" www.ghalkes.nl:os.ghalkes.nl/dist/ ; then
	echo "Failed to upload package"
	exit 1
fi
