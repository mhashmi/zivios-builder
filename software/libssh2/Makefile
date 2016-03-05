MAKE ?= make
LIBSSH_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(LIBSSH_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
LIBSSH_VERSION ?= 1.2.4
LIBSSH_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libssh2/libssh2-$(LIBSSH_VERSION).tgz
LIBSSH_SOURCE := $(LIBSSH_ROOT)/libssh2-$(LIBSSH_VERSION)

OPENSSL_VERSION ?= 0.9.8l
OPENSSL_LIB_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib

ZLIB_VERSION ?= 1.2.3
ZLIB_BASE_DIR ?= $(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION)

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/libssh2-$(LIBSSH_VERSION).tar.gz; \
	cd libssh2-$(LIBSSH_VERSION); \
	LDFLAGS="-L$(OPENSSL_LIB_DIR) -Wl,-rpath,$(OPENSSL_LIB_DIR)" \
	LD_LIBRARY_PATH=$(OPENSSL_LIB_DIR) \
	CPPFLAGS="-I$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/include" \
	./configure \
	--prefix=$(ZIVIOS_HOME)/libssh2-$(LIBSSH_VERSION) \
	--with-libz=$(ZLIB_BASE_DIR) \
	--with-openssl=$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION); \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR) $(MAKE); LD_RUN_PATH=$(OPENSSL_LIB_DIR) $(MAKE) install)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libssh2
	(cd $(ZIVIOS_HOME); tar czf $(LIBSSH_TGZ_TARGET) libssh2-$(LIBSSH_VERSION))

clean:
	/bin/rm -rf libssh2-$(LIBSSH_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/libssh2-$(LIBSSH_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/libssh2

pkgclean: 
	/bin/rm -f $(LIBSSH_TGZ_TARGET)
