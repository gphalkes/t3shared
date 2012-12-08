# Rules for files generated from the shared directories.
# Define T3NAME before including this file.

ifndef T3NAME
$(error T3NAME not defined. See $(lastword $(MAKEFILE_LIST)) for details)
endif

T3NAME_UPPER:=$(shell echo '$(T3NAME)' | tr [[:lower:]] [[:upper:]])
T3PATH:=$(dir $(lastword $(MAKEFILE_LIST)))
T3HEADERS:=$(foreach NAME,errors api,$(T3NAME)_$(NAME).h)
T3SOURCES:=$(foreach NAME,shared,$(T3NAME)_$(NAME).c)

$(T3NAME)_%.h: $(T3PATH)/src/%.h
	$(_VERBOSE_GEN) sed "s/SHARED/$(T3NAME_UPPER)/g;s/shared/$(T3NAME)/g" $< > $@
$(T3NAME)_%.c: $(T3PATH)/src/%.c
	$(_VERBOSE_GEN) sed "s/SHARED/$(T3NAME_UPPER)/g;s/shared/$(T3NAME)/g" $< > $@
$(OBJECTS): $(T3HEADERS)

clean::
	rm -rf $(T3HEADERS) $(T3SOURCES) 2> /dev/null

.SECONDARY: $(T3HEADERS) $(T3SOURCES)

ifeq ($(BUILDVERSION),debug)
LCFLAGS += -DT3_DONT_CHECK_VERSION
LCXXFLAGS += -DT3_DONT_CHECK_VERSION
endif

LCFLAGS += -DT3_$(T3NAME_UPPER)_BUILD_DSO
LCXXFLAGS += -DT3_$(T3NAME_UPPER)_BUILD_DSO
CFLAGS += -I../include
CXXFLAGS += -I../include
