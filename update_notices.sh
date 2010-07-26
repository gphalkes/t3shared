#!/bin/bash

#cd `dirname "$0"`
SCRIPT=`basename "$0"`
FILES=`hg manifest | egrep -v "^($SCRIPT|testsuite/.*|src/Makefile)$"`


for f in $FILES ; do
	if head -n1 $f | egrep -q 'Copyright \(C\)' ; then

		notice="`head -n1 $f | egrep 'Copyright \(C\)' | sed -r 's/^.*([0-9]{4})[^0-9]*$/\1/'`"
		change="`hg log --no-merges --limit 1 --template '{date|isodate}' $f | egrep -o '^[0-9]+'`"

		if [ "$notice" != "$change" ] ; then
			echo "Updating Copyright notice for $f:"
			if head -n1 $f | egrep -q '[0-9]{4}-[0-9]{4}' ; then
				sed -i -r "1s/([0-9]{4}-)[0-9]{4}/\\1$change/" $f
			else
				sed -i -r "1s/([0-9]{4})([^0-9]+)/\\1-$change\\2/" $f
			fi
			head -n1 $f  | sed -r 's/^/  /'
		fi
	fi

	if tail -n+2 $f | egrep -q 'Copyright (\(C\)|\\\(co)' ; then

		notice="`tail -n+2 $f | egrep 'Copyright (\(C\)|\\\(co)' | sed -r 's/^.*([0-9]{4})[^0-9]*$/\1/'`"
		change="`hg log --no-merges --limit 1 --template '{date|isodate}' | egrep -o '^[0-9]+'`"

		if [ "$notice" != "$change" ] ; then
			echo "Updating Copyright notice inside $f:"
			if tail -n+2 $f | egrep -q '[0-9]{4}-[0-9]{4}' ; then
				sed -i -r "2,\$s/([0-9]{4}-)[0-9]{4}/\\1$change/" $f
			else
				sed -i -r "2,\$s/([0-9]{4})([^0-9]+)/\\1-$change\\2/" $f
			fi
			tail -n+2 $f | egrep 'Copyright (\(C\)|\\\(co)' | sed -r 's/^/  /'
		fi
	fi
done
