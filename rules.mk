# Rules for files generated from the shared directories.
# Define T3NAME before including this file.

ifndef T3NAME
$(error T3NAME not defined. See $(lastword $(MAKEFILE_LIST)) for details)
endif

T3PATH:=$(dir $(lastword $(MAKEFILE_LIST)))
T3HEADERS:=$(foreach NAME,errors api,$(T3NAME)_$(NAME).h)

$(T3NAME)_%.h: $(T3PATH)/src/%.h
	$(_VERBOSE_GEN) sed "s/SHARED/`echo '$(T3NAME)' | tr [[:lower:]] [[:upper:]]`/g;s/shared/$(T3NAME)/g" $< > $@
$(OBJECTS): $(T3HEADERS)

clean::
	rm -rf $(T3HEADERS) 2> /dev/null
