# Rules for documentation files generated from the shared directories.
# Define T3NAME before including this file.

ifndef T3NAME
$(error T3NAME not defined. See $(lastword $(MAKEFILE_LIST)) for details)
endif

T3PATH:=$(dir $(lastword $(MAKEFILE_LIST)))
T3DOCS:=doxygen.conf DoxygenLayout.xml
T3UNAME:=$(shell echo '$(T3NAME)' | tr [[:lower:]] [[:upper:]])
T3CXX?=0

doxygen: doxygen.conf DoxygenLayout.xml
	doxygen doxygen.conf

doxygen.conf: $(T3PATH)/doc/doxygen.conf
	sed 's/<NAME>/libt3$(T3NAME)/g;s/<UNAME>/$(T3UNAME)/g;s/<DEFINITIONS>/$(DOXYGENDEFS)/g' '$<' > '$@'
	if [ $(T3CXX) -ne 0 ] ; then sed -r -i '/^(EXTRACT_STATIC|SHOW_NAMESPACES)/s/NO/YES/;/^(OPTIMIZE_OUTPUT_FOR_C|HIDE_UNDOC_(CLASSES|MEMBERS))/s/YES/NO/;' $@ ; fi
	if [ -f format.md ] ; then sed -i 's/main_doc.h/main_doc.h format.md/g' doxygen.conf ; fi

DoxygenLayout.xml: $(T3PATH)/doc/DoxygenLayout.xml
	cp '$<' '$@'

clean::
	rm -rf $(T3DOCS) API 2> /dev/null

upload: doxygen
	find API -type f -exec chmod 0644 '{}' ';'
	find API -type d -exec chmod 0755 '{}' ';'
	rsync -arv --delete API/ www.ghalkes.nl:os.ghalkes.nl/doc/libt3$(T3NAME)/

.PHONY: clean doxygen