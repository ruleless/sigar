TOPDIR:=..

DIRS:=$(TOPDIR)/src $(TOPDIR)/src/os/linux
OBJS:=$(foreach v,$(DIRS),$(wildcard $(v)/*.o))

LIB:=libsigar.a
LIBPATH:=$(TOPDIR)/lib

include ./build.mak
