MAKE ?= make
MAKEARGS ?= 
CURL_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(CURL_ROOT)/../..; pwd)
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
CURL_VERSION ?= 7.20.0
CURL_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/curl/curl-$(CURL_VERSION).tgz
CURL_SOURCE := $(CURL_ROOT)/curl-$(CURL_VERSION)

OPENSSL_VERSION ?= 0.9.8l
OPENSSL_BASE_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)
OPENSSL_LIB_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib
OPENSSL_INC_DIR ?= $(OPENSSL_BASE_DIR)/include

LDAP_VERSION ?= 2.4.21
LDAP_BASE_DIR ?= $(ZIVIOS_HOME)/openldap-$(LDAP_VERSION)
LDAP_LIB_DIR ?= $(LDAP_BASE_DIR)/lib
LDAP_INC_DIR ?= $(LDAP_BASE_DIR)/include

ZLIB_VERSION ?= 1.2.3
ZLIB_BASE_DIR ?= $(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION)
ZLIB_LIB_DIR ?= $(ZLIB_BASE_DIR)/lib
ZLIB_INC_DIR ?= $(ZLIB_BASE_DIR)/include

HEIMDAL_VERSION ?= 1.3.1
HEIMDAL_BASE_DIR ?= $(ZIVIOS_HOME)/heimdal-$(HEIMDAL_VERSION)
HEIMDAL_LIB_DIR ?= $(HEIMDAL_BASE_DIR)/lib
HEIMDAL_INC_DIR ?= $(HEIMDAL_BASE_DIR)/include

LIBSSH2_VERSION ?= 1.2.4
LIBSSH2_BASE_DIR ?= $(ZIVIOS_HOME)/libssh2-$(LIBSSH2_VERSION)
LIBSSH2_LIB_DIR ?= $(LIBSSH2_BASE_DIR)/lib
LIBSSH2_INC_DIR ?= $(LIBSSH2_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/curl-$(CURL_VERSION).tar.gz; \
	cd curl-$(CURL_VERSION); \
	LDFLAGS="-L$(OPENSSL_LIB_DIR) -Wl,-rpath,$(OPENSSL_LIB_DIR) -L$(ZLIB_LIB_DIR) -L$(LDAP_LIB_DIR) -Wl,-rpath,$(LDAP_LIB_DIR) -L$(HEIMDAL_LIB_DIR) -Wl,-rpath,$(HEIMDAL_LIB_DIR) -L$(LIBSSH2_LIB_DIR) -Wl,-rpath,$(LIBSSH2_LIB_DIR)" \
	LD_LIBRARY_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR):$(LDAP_LIB_DIR):$(HEIMDAL_LIB_DIR):$(LIBSSH2_LIB_DIR) \
	CPPFLAGS="-I$(OPENSSL_INC_DIR) -I$(ZLIB_INC_DIR) -I$(LDAP_INC_DIR) -I$(HEIMDAL_INC_DIR):$(LIBSSH2_INC_DIR)" \
	./configure --prefix=$(ZIVIOS_HOME)/curl-$(CURL_VERSION) \
	--enable-static=yes \
	--enable-shared=no \
	--disable-manual \
	--disable-tftp \
	--disable-ftp \
	--without-libssh2 \
	--disable-sftp \
	--enable-ldap \
	--enable-ldaps \
	--enable-http \
	--with-zlib=$(ZLIB_BASE_DIR) \
	--with-ssl=$(OPENSSL_BASE_DIR) \
	--with-gssapi-includes=$(HEIMDAL_INC_DIR) \
	--with-gssapi-libs=$(HEIMDAL_LIB_DIR) \
	--with-gssapi=$(HEIMDAL_BASE_DIR) \
	--with-ca-path=$(ZIVIOS_HOME)/zivios-ca/anchors; \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR):$(LDAP_LIB_DIR):$(HEIMDAL_LIB_DIR):$(LIBSSH2_LIB_DIR) $(MAKE) $(MAKEARGS); \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR):$(LDAP_LIB_DIR):$(HEIMDAL_LIB_DIR):$(LIBSSH2_LIB_DIR) $(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s curl-$(CURL_VERSION) curl)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/curl
	(cd $(ZIVIOS_HOME); tar czf $(CURL_TGZ_TARGET) curl-$(CURL_VERSION))

clean:
	/bin/rm -rf curl-$(CURL_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/curl-$(CURL_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/curl

plat:
	@echo "Platform is $(PLAT)"
