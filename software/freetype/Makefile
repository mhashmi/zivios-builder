MAKE ?= make
MAKEARGS ?=
FREETYPE_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(FREETYPE_ROOT)/../..; pwd)
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
FREETYPE_VERSION ?= 2.3.12
FREETYPE_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/freetype/freetype-$(FREETYPE_VERSION).tgz
FREETYPE_SOURCE := $(FREETYPE_ROOT)/freetype-$(FREETYPE_VERSION)

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/freetype-$(FREETYPE_VERSION).tar.gz; \
	cd freetype-$(FREETYPE_VERSION); \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/freetype-$(FREETYPE_VERSION) \
	--enable-static=yes \
	--enable-shared=no; \
	$(MAKE) $(MAKEARGS); \
	$(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s freetype-$(FREETYPE_VERSION) freetype)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/freetype
	(cd $(ZIVIOS_HOME); tar czf $(FREETYPE_TGZ_TARGET) freetype-$(FREETYPE_VERSION))

clean:
	/bin/rm -rf freetype-$(FREETYPE_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/freetype-$(FREETYPE_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/freetype

plat:
	@echo "Platform is $(PLAT)"
