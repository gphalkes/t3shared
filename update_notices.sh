#!/bin/bash

SCRIPT=`basename "$0"`
if ! [ -e .hg ] ; then
	echo "Please run this script in the top of the mercurial repository"
	exit
fi
FILES=`{ hg manifest | egrep -v "^($SCRIPT|testsuite/.*|src/Makefile)$" ; [ -e .notice_mask ] && { cat .notice_mask ; echo ; cat .notice_mask ; } ; } | sort | uniq -u`

want_update() {
	ANSWER=x
	while [ "$ANSWER" != "y" ] && [ "$ANSWER" != "n" ] ; do
		read -n1 -p "Do you want to update this notice? " ANSWER < /dev/tty
		echo
	done
	[ "$ANSWER" = "y" ]
}

for f in $FILES ; do
	if egrep -q 'Copyright (\(C\)|\\\(co)' $f ; then
		change="`hg log --no-merges --limit 1 --template '{date|isodate}' | egrep -o '^[0-9]+'`"
		change_file="`hg log --no-merges --limit 1 --template '{date|isodate}' $f | egrep -o '^[0-9]+'`"

		first=y
		egrep -n 'Copyright (\(C\)|\\\(co)' $f | sed 's/:/ /' | while read LINENR LINE ; do
			if [ "$first" = y ] ; then
				check_change="$change_file"
				first=n
			else
				check_change="$change"
			fi

			notice="`echo \"$LINE\" | sed -r 's/^.*([0-9]{4})[^0-9]*$/\1/'`"

			if [ "$notice" != "$check_change" ] ; then
				echo "Updating Copyright notice in $f on line $LINENR:"
				sed "${LINENR}!d" $f

				want_update || continue

				if echo "$LINE" | egrep -q '[0-9]{4}-[0-9]{4}[^0-9]+$' ; then
					sed -i -r "${LINENR}s/([0-9]{4}-)[0-9]{4}([^0-9]+)$/\\1$check_change\\2/" $f
				else
					sed -i -r "${LINENR}s/([0-9]{4})([^0-9]+)$/\\1-$check_change\\2/" $f
				fi
				sed "${LINENR}!d" $f
			fi
		done
	fi
done
