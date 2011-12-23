
DIRS := ../../transcript ../config ../highlight ../key ../window ../widget ../edit
TARGETS := $(foreach DIR,$(DIRS), $(shell $(MAKE) -q -C $(DIR)/src >/dev/null || echo $(DIR)))

$(warning TARGETS: $(TARGETS))

all:
	@for DIR in $(TARGETS) ; do make -C $$DIR/src ; done
