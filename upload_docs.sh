#!/bin/bash

die() {
	echo "$*"
	exit 1
}

if [[ $# -ne 1 ]] ; then
	echo "Usage: upload_docs.sh <release tar file>"
	exit 1
fi

TAR="$(readlink -f "$1")"
PKG=${1%%-*}
PKG=${PKG##*/}

case $PKG in
	libt3config|libt3highlight|libt3key|libt3widget|libt3window)
		;;
	*)
		echo "Unknown package $PKG for upload"
		exit 1
		;;
esac

TEMPDIR="$(mktemp -d --tmpdir uploadXXXXXX)"
pushd "$TEMPDIR" >/dev/null || die "cd to tempdir"
tar xf "$TAR"
mv "$PKG"*/doc/API "$PKG"
chmod -R go+r "$PKG"
find "$PKG" -type f -exec chmod 0644 '{}' ';'
find "$PKG" -type d -exec chmod 0755 '{}' ';'
rsync -arv --delete "$PKG" www.ghalkes.nl:os.ghalkes.nl/t3/doc/
popd >/dev/null || die "popd from tempdir"
rm -rf "$TEMPDIR"
