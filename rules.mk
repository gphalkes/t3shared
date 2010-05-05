# Rules for files generated from the shared directories.
# Define T3NAME before including this file.

ifndef T3NAME
$(error T3NAME not defined. See $(lastword $(MAKEFILE_LIST)) for details)
endif


T3PATH:=$(dir $(lastword $(MAKEFILE_LIST)))
$(T3NAME)_%.h: $(T3PATH)/src/%.h
	sed "s/SHARED/`echo '$(T3NAME)' | tr [[:lower:]] [[:upper:]]`/g;s/shared/$(T3NAME)/g" $< > $@
