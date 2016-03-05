MAKE ?= make
MAKEARGS ?= 
LIBPNG_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(LIBPNG_ROOT)/../..; pwd)
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
LIBPNG_VERSION ?= 1.4.0
LIBPNG_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libpng/libpng-$(LIBPNG_VERSION).tgz
LIBPNG_SOURCE := $(LIBPNG_ROOT)/libpng-$(LIBPNG_VERSION)

ZLIB_VERSION ?= 1.2.3
ZLIB_BASE_DIR := $(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION)
ZLIB_LIB_DIR := $(ZLIB_BASE_DIR)/lib
ZLIB_INC_DIR := $(ZLIB_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/libpng-$(LIBPNG_VERSION).tar.gz; \
	cd libpng-$(LIBPNG_VERSION); \
	LDFLAGS="-L$(ZLIB_LIB_DIR)" \
	CPPFLAGS="-I$(ZLIB_INC_DIR)" \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/libpng-$(LIBPNG_VERSION) \
	--with-zlib=$(ZLIB_BASE_DIR) \
	--enable-static=yes \
	--enable-shared=no; \
	LD_RUN_PATH=$(ZLIB_LIB_DIR) $(MAKE) $(MAKEARGS); \
	LD_RUN_PATH=$(ZLIB_LIB_DIR) $(MAKE) install)
	(cd $(ZIVIOS_HOME); ln -s libpng-$(LIBPNG_VERSION) libpng)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libpng
	(cd $(ZIVIOS_HOME); tar czf $(LIBPNG_TGZ_TARGET) libpng-$(LIBPNG_VERSION))

clean:
	/bin/rm -rf libpng-$(LIBPNG_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/libpng-$(LIBPNG_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/libpng

plat:
	@echo "Platform is $(PLAT)"
