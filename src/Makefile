phonyt:=all

TOPDIR:=..

LIB:=libsigar.a
LIBPATH:=$(TOPDIR)/lib/

dirs:=os

CFLAGS:=-I $(TOPDIR)/include -I os/linux
LDFLAGS:=

SPECOBJS:=$(patsubst %.c,%.o,$(wildcard os/linux/*.c))

include $(TOPDIR)/common.mak
