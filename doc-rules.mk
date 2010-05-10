# Rules for documentation files generated from the shared directories.
# Define T3NAME before including this file.

ifndef T3NAME
$(error T3NAME not defined. See $(lastword $(MAKEFILE_LIST)) for details)
endif

T3PATH:=$(dir $(lastword $(MAKEFILE_LIST)))
T3DOCS:=doxygen.conf DoxygenLayout.xml

doxygen: doxygen.conf DoxygenLayout.xml
	doxygen doxygen.conf

doxygen.conf: $(T3PATH)/doc/doxygen.conf
	sed 's/<NAME>/libt3$(T3NAME)/g' '$<' > '$@'

DoxygenLayout.xml: $(T3PATH)/doc/DoxygenLayout.xml
	cp '$<' '$@'

clean::
	rm -rf $(T3DOCS) API 2> /dev/null

.PHONY: clean doxygen