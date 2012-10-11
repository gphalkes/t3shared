#!/bin/bash

if [ $# -eq 0 ] ; then
	TESTS="config key highlight window widget edit"
else
	TESTS="$*"
fi

cd `dirname "$0"`/..
for i in $TESTS ; do
	[ -x "$i/testsuite/runtests.sh" ] || continue
	echo "==== Running testsuite for $i ===="
	( cd "$i/testsuite" ; ./runtests.sh )
done
