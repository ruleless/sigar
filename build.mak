phonyt?=allt

CC=clang
CXX=clang++
MAKE=make

CFLAGS+=-g -Wall
CXXFLAGS+=-g -Wall

AR=ar cr
RM=-rm -rf

# dirs:=$(shell find . -maxdepth 1 -type d)
# dirs:=$(basename $(patsubst ./%,%,$(dirs)))
# dirs:=$(filter-out $(exclude_dirs),$(dirs))
SUBDIRS:=$(dirs)

SRCS=$(wildcard *.c)
OBJS=$(SRCS:%.c=%.o)
DEPENDS=$(SRCS:%.c=%.d)


# Phony target
.PHONY:allt fake objt subdirs

default:$(phonyt)

allt:$(LIBPATH) $(EXEPATH) $(TARGET) $(LIB) subdirs
objt:$(OBJS) subdirs

$(LIBPATH):
	mkdir $(LIBPATH)
$(EXEPATH):
	mkdir $(EXEPATH)


# First Layer
$(TARGET):$(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)
ifdef EXEPATH
	cp $@ $(EXEPATH)
endif

$(LIB):$(OBJS)
	$(AR)  $@  $^
ifdef LIBPATH
	cp $@ $(LIBPATH)
endif

subdirs:$(SUBDIRS)
	for dir in $(SUBDIRS); \
		do $(MAKE) -C $$dir||exit 1; \
	done


# Second Layer for object file deprule
$(OBJS):%.o:%.c
	$(CC) -c $< -o $@ $(CFLAGS)

## Second Layer for dependency file deprule
-include $(DEPENDS)

$(DEPENDS):%.d:%.c
	set -e; rm -f $@; \
	$(CC) -MM $(CFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[:]*,\1.o $@:,g' < $@.$$$$ > $@; \
	rm $@.$$$$


# clean
clean:
	for dir in $(SUBDIRS);\
		do $(MAKE) -C $$dir clean||exit 1;\
	done
	$(RM) $(TARGET) $(LIB)  $(OBJS) $(DEPENDS)


# for debug
fake:
	@echo $(SUBDIRS)
