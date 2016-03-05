MAKE ?= make
MAKEARGS := -j1
OPENSSL_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(OPENSSL_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
OPENSSL_VERSION ?=  0.9.8l
OPENSSL_BASE_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)
OPENSSL_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/openssl/openssl-$(OPENSSL_VERSION).tgz

ZLIB_VERSION ?= 1.2.3
ZLIB_BASE_DIR ?= $(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION)
ZLIB_LIB_DIR ?= $(ZLIB_BASE_DIR)/lib
ZLIB_INC_DIR ?= $(ZLIB_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), Ubuntu-x86_64)
	PLAT := linux-x86_64
endif

ifeq ($(BUILD_PLATFORM), Debian-x86_64)
	PLAT := linux-x86_64
endif

ifeq ($(BUILD_PLATFORM), CentOS-x86_64)
	PLAT := linux-x86_64
endif

ifeq ($(PLAT), )
	PLAT := linux-elf
endif

all: build tar

build: 
	(tar xzf src/openssl-$(OPENSSL_VERSION).tar.gz; \
	cd openssl-$(OPENSSL_VERSION); \
	CFLAGS="-g -O2" \
	CXXFLAGS="-g -O2" \
	PERL=/usr/bin/perl \
	LDFLAGS="-L$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib:$(ZLIB_LIB_DIR)" \
	$(ENVMOD) LD_RUN_PATH=$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib:$(ZLIB_LIB_DIR) ./Configure --prefix=$(OPENSSL_BASE_DIR) zlib -L$(ZLIB_LIB_DIR) -I$(ZLIB_INC_DIR) \
	shared $(PLAT) -g -O2; \
	LD_RUN_PATH=$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib $(MAKE) $(MAKEARGS); \
	LD_RUN_PATH=$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib $(MAKE) install)
	(cd $(ZIVIOS_HOME); ln -s openssl-$(OPENSSL_VERSION) openssl)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/openssl
	(cd $(ZIVIOS_HOME); tar czf $(OPENSSL_TGZ_TARGET) openssl-$(OPENSSL_VERSION))

platform:
	echo $(BUILD_PLATFORM);
	echo $(PLAT);

clean:
	/bin/rm -rf openssl-$(OPENSSL_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/openssl
