#!/bin/bash

if [ $# -eq 0 ] ; then
	TESTS="config key highlight window widget tilde"
else
	TESTS="$*"
fi

cd `dirname "$0"`/..
for i in $TESTS ; do
	[ -x "$i/testsuite/runtests.sh" ] || continue
	echo -e "\033[34;1m/// Running testsuite for $i ///\033[0m"
	( cd "$i/testsuite" ; ./runtests.sh ) | sed -r '$s/(.*)/\x1b[35;1m\1\x1b[0m/'
done
