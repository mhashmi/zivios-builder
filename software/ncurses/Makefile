MAKE ?= make
MAKEARGS ?= 
NCURSES_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(NCURSES_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ifeq ($(BUILD_PLATFORM), )
	BUILD_PLATFORM := "UNKNOWN"
endif

ifeq ($(BUILD_PLATFORM), Ubuntu-x86_64)
	PLAT := x86_64-pc-linux-gnu
endif

ifeq ($(BUILD_PLATFORM), Debian-x86_64)
	PLAT := x86_64-pc-linux-gnu
endif

ifeq ($(PLAT), )
	PLAT := i386-pc-linux-gnu
endif

ZIVIOS_HOME ?= /opt/zivios
NCURSES_VERSION ?= 5.7
NCURSES_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/ncurses/ncurses-$(NCURSES_VERSION).tgz
NCURSES_SOURCE := $(NCURSES_ROOT)/ncurses-$(NCURSES_VERSION)

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/ncurses-$(NCURSES_VERSION).tar.gz; \
	cd ncurses-$(NCURSES_VERSION); \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/ncurses-$(NCURSES_VERSION) \
	--enable-static=yes \
	--enable-shared=no \
	--without-debug \
	--without-ada \
	--without-cxx \
	--without-cxx-binding \
	--without-normal; \
	$(MAKE) $(MAKEARGS); \
	$(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s ncurses-$(NCURSES_VERSION) ncurses)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/ncurses
	(cd $(ZIVIOS_HOME); tar czf $(NCURSES_TGZ_TARGET) ncurses-$(NCURSES_VERSION))

clean:
	/bin/rm -rf ncurses-$(NCURSES_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/ncurses-$(NCURSES_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/ncurses

plat:
	@echo "Platform is $(PLAT)"
