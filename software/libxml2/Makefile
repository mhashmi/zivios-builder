MAKE ?= make
MAKEARGS ?= 
LIBXML2_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(LIBXML2_ROOT)/../..; pwd)
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
LIBXML2_VERSION ?= 2.7.6
LIBXML2_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libxml2/libxml2-$(LIBXML2_VERSION).tgz
LIBXML2_SOURCE := $(LIBXML2_ROOT)/libxml2-$(LIBXML2_VERSION)

ICONV_VERSION ?= 1.13.1
ICONV_BASE_DIR ?= $(ZIVIOS_HOME)/iconv-$(ICONV_VERSION)
ICONV_LIB_DIR ?= $(ICONV_BASE_DIR)/lib
ICONV_INC_DIR ?= $(ICONV_BASE_DIR)/include

ZLIB_VERSION ?= 1.2.3
ZLIB_BASE_DIR ?= $(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION)
ZLIB_LIB_DIR ?= $(ZLIB_BASE_DIR)/lib
ZLIB_INC_DIR ?= $(ZLIB_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/libxml2-$(LIBXML2_VERSION).tar.gz; \
	cd libxml2-$(LIBXML2_VERSION); \
	LDFLAGS="-L$(ZLIB_LIB_DIR) -L$(ICONV_LIB_DIR)" \
	LD_LIBRARY_PATH=$(ZLIB_LIB_DIR):$(ICONV_LIB_DIR) \
	CPPFLAGS="-I$(ICONV_INC_DIR) -I$(ZLIB_INC_DIR)" \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/libxml2-$(LIBXML2_VERSION) \
	--disable-shared \
	--enable-static \
	--with-zlib=$(ZLIB_BASE_DIR) \
	--with-iconv=$(ICONV_BASE_DIR) \
	--without-python; \
	LD_RUN_PATH=$(ICONV_LIB_DIR):$(ZLIB_LIB_DIR) $(MAKE) $(MAKEARGS); \
	LD_RUN_PATH=$(ICONV_LIB_DIR):$(ZLIB_LIB_DIR) $(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s libxml2-$(LIBXML2_VERSION) libxml2)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libxml2
	(cd $(ZIVIOS_HOME); tar czf $(LIBXML2_TGZ_TARGET) libxml2-$(LIBXML2_VERSION))

clean:
	/bin/rm -rf libxml2-$(LIBXML2_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/libxml2-$(LIBXML2_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/libxml2

plat:
	@echo "Platform is $(PLAT)"
