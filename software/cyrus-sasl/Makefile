CYRUS_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(CYRUS_ROOT)/../..; pwd)
MAKE ?= make
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

ifeq ($(BUILD_PLATFORM), CentOS-x86_64)
	PLAT := x86_64-pc-linux-gnu
endif

ifeq ($(PLAT), )
	PLAT := i386-pc-linux-gnu
endif

ZIVIOS_HOME ?= /opt/zivios

CYRUS_VERSION ?= 2.1.23
CYRUS_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/cyrus-sasl/cyrus-sasl-$(CYRUS_VERSION).tgz
CYRUS_LIB_DIR ?= $(ZIVIOS_HOME)/cyrus-sasl-$(CYRUS_VERSION)/lib

HEIMDAL_VERSION ?= 1.3.1
OPENSSL_VERSION ?= 0.9.8l
BDB_VERSION ?= 4.8.26

HEIMDAL_LIB_DIR ?= $(ZIVIOS_HOME)/heimdal-$(HEIMDAL_VERSION)/lib
HEIMDAL_INC_DIR ?= $(ZIVIOS_HOME)/heimdal-$(HEIMDAL_VERSION)/include
OPENSSL_LIB_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib

all: build tar

build:
	(tar xzf src/cyrus-sasl-$(CYRUS_VERSION).tar.gz; \
	cd cyrus-sasl-$(CYRUS_VERSION); \
	LDFLAGS="-L$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib -Wl,-rpath,$(OPENSSL_LIB_DIR) -L$(HEIMDAL_LIB_DIR) -Wl,-rpath,$(HEIMDAL_LIB_DIR)" CFLAGS="-DWITH_SSL_DES -D_REENTRANT -g -O2 -I$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/include -I$(HEIMDAL_INC_DIR)" ./configure --prefix=$(ZIVIOS_HOME)/cyrus-sasl-$(CYRUS_VERSION) \
	--build=$(PLAT) \
	--host=$(PLAT) \
	--target=$(PLAT) \
	--with-saslauthd=$(ZIVIOS_HOME)/cyrus-sasl-$(CYRUS_VERSION)/state \
	--with-plugindir=$(ZIVIOS_HOME)/cyrus-sasl-$(CYRUS_VERSION)/lib/sasl2 \
	--with-dblib=berkeley \
	--with-bdb-libdir=$(ZIVIOS_HOME)/bdb-$(BDB_VERSION)/lib \
	--with-bdb-incdir=$(ZIVIOS_HOME)/bdb-$(BDB_VERSION)/inc \
	--with-openssl=$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION) \
	--with-gss_impl=heimdal \
	--enable-gssapi=$(ZIVIOS_HOME)/heimdal-$(HEIMDAL_VERSION) \
	--enable-login; \
	../sed.sh; \
	$(MAKE); \
	$(MAKE) install)
	(cd $(ZIVIOS_HOME); ln -s cyrus-sasl-$(CYRUS_VERSION) cyrus-sasl)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/cyrus-sasl
	(cd $(ZIVIOS_HOME); tar czf $(CYRUS_TGZ_TARGET) cyrus-sasl-$(CYRUS_VERSION))

clean:
	/bin/rm -rf cyrus-sasl-$(CYRUS_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/cyrus-sasl-$(CYRUS_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/cyrus-sasl
