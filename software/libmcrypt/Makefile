MAKE ?= make
MAKEARGS ?= 
LIBMCRYPT_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(LIBMCRYPT_ROOT)/../..; pwd)
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
LIBMCRYPT_VERSION ?= 2.5.8
LIBMCRYPT_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libmcrypt/libmcrypt-$(LIBMCRYPT_VERSION).tgz
LIBMCRYPT_SOURCE := $(MCRYPT_ROOT)/libmcrypt-$(lIBMCRYPT_VERSION)

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/libmcrypt-$(LIBMCRYPT_VERSION).tar.gz; \
	cd libmcrypt-$(LIBMCRYPT_VERSION); \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/libmcrypt-$(LIBMCRYPT_VERSION) \
	--enable-static=yes \
	--enable-shared=no; \
	$(MAKE) $(MAKEARGS); \
	$(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s libmcrypt-$(LIBMCRYPT_VERSION) libmcrypt)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libmcrypt
	(cd $(ZIVIOS_HOME); tar czf $(LIBMCRYPT_TGZ_TARGET) libmcrypt-$(LIBMCRYPT_VERSION))

clean:
	/bin/rm -rf libmcrypt-$(LIBMCRYPT_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/libmcrypt-$(LIBMCRYPT_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/libmcrypt

plat:
	@echo "Platform is $(PLAT)"
