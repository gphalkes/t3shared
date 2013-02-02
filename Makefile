DIRS := ../../transcript ../t3config ../t3highlight ../t3key ../t3window ../t3widget ../tilde
TARGETS := $(foreach DIR,$(DIRS), $(shell $(MAKE) -q -C $(DIR)/src >/dev/null || echo $(DIR)))

$(warning TARGETS: $(TARGETS))

all:
	@for DIR in $(TARGETS) ; do make -C $$DIR/src ; done
