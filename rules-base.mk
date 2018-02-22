# Rules for compling/linking against the t3 libraries

T3BASEPATH:=$(dir $(lastword $(MAKEFILE_LIST)))..

CFLAGS += -I$(T3BASEPATH)/t3shared/include
CXXFLAGS += -I$(T3BASEPATH)/t3shared/include
T3LDFLAGS.t3config = $(call L,$(T3BASEPATH)/t3config/src/.libs)
T3LDFLAGS.t3highlight = $(call L,$(T3BASEPATH)/t3highlight/src/.libs)
T3LDFLAGS.t3key = $(call L,$(T3BASEPATH)/t3key/src/.libs)
T3LDFLAGS.t3window = $(call L,$(T3BASEPATH)/t3window/src/.libs)
T3LDFLAGS.t3widget = $(call L,$(T3BASEPATH)/t3widget/src/.libs)
T3LDFLAGS.transcript = $(call L, $(T3BASEPATH)/transcript/src/.libs)
