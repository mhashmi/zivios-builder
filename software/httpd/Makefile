MAKE ?= make
MAKEARGS ?= 
HTTPD_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(HTTPD_ROOT)/../..; pwd)
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
HTTPD_VERSION ?= 2.2.14
HTTPD_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/httpd/httpd-$(HTTPD_VERSION).tgz
HTTPD_SOURCE := $(HTTPD_ROOT)/httpd-$(HTTPD_VERSION)

OPENSSL_VERSION ?= 0.9.8l
OPENSSL_BASE_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)
OPENSSL_LIB_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib
OPENSSL_INC_DIR ?= $(OPENSSL_BASE_DIR)/include

ZLIB_VERSION ?= 1.2.3
ZLIB_BASE_DIR ?= $(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION)
ZLIB_LIB_DIR ?= $(ZLIB_BASE_DIR)/lib
ZLIB_INC_DIR ?= $(ZLIB_BASE_DIR)/include

EXPAT_VERSION ?= 2.0.1
EXPAT_BASE_DIR ?= $(ZIVIOS_HOME)/expat-$(EXPAT_VERSION)
EXPAT_LIB_DIR ?= $(EXPAT_BASE_DIR)/lib
EXPAT_INC_DIR ?= $(EXPAT_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xjf src/httpd-$(HTTPD_VERSION).tar.bz2; \
	cd httpd-$(HTTPD_VERSION); \
	LDFLAGS="-L$(OPENSSL_LIB_DIR) -Wl,-rpath,$(OPENSSL_LIB_DIR) -L$(EXPAT_LIB_DIR) -Wl,-rpath,$(EXPAT_LIB_DIR) -L$(ZLIB_LIB_DIR) -Wl,-rpath,$(ZLIB_LIB_DIR)" \
	LD_LIBRARY_PATH=$(OPENSSL_LIB_DIR):$(EXPAT_LIB_DIR):$(ZLIB_LIB_DIR) \
	CPPFLAGS="-I$(OPENSSL_INC_DIR) -I$(ICONV_INC_DIR) -I$(ZLIB_INC_DIR)" \
	./configure --prefix=$(ZIVIOS_HOME)/httpd-$(HTTPD_VERSION) \
	--with-included-apr \
	--enable-static=yes \
	--enable-so \
	--enable-static-support \
	--with-ssl=$(OPENSSL_BASE_DIR) \
	--with-mpm=prefork \
	--with-z=$(ZLIB_BASE_DIR) \
	--with-expat=$(EXPAT_BASE_DIR) \
	--enable-rewrite \
	--enable-ssl; \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR):$(EXPAT_LIB_DIR) $(MAKE) $(MAKEARGS); \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR):$(EXPAT_LIB_DIR) $(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s httpd-$(HTTPD_VERSION) httpd)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/httpd
	(cd $(ZIVIOS_HOME); tar czf $(HTTPD_TGZ_TARGET) httpd-$(HTTPD_VERSION))

clean:
	/bin/rm -rf httpd-$(HTTPD_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/httpd-$(HTTPD_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/httpd

plat:
	@echo "Platform is $(PLAT)"
