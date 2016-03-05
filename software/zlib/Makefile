MAKE ?= make
MAKEARGS ?= -j2
ZLIB_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(ZLIB_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
ZLIB_VERSION ?= 1.2.3
ZLIB_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/zlib/zlib-$(ZLIB_VERSION).tgz
ZLIB_SOURCE := $(ZLIB_ROOT)/zlib-$(ZLIB_VERSION)

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/zlib-$(ZLIB_VERSION).tar.gz; \
	cd zlib-$(ZLIB_VERSION); \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION); \
	$(MAKE) install)
	(cd $(ZIVIOS_HOME); ln -s zlib-$(ZLIB_VERSION) zlib)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/zlib
	(cd $(ZIVIOS_HOME); tar czf $(ZLIB_TGZ_TARGET) zlib-$(ZLIB_VERSION))

clean:
	/bin/rm -rf zlib-$(ZLIB_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/zlib
