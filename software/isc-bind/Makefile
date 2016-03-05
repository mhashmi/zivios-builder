MAKE ?= make
MAKEARGS ?= -j2
BIND_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(BIND_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
BIND_VERSION ?= 9.7.0
BIND_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/isc-bind/bind-$(BIND_VERSION).tgz
BIND_SOURCE := $(BIND_ROOT)/bind-$(BIND_VERSION)

OPENSSL_VERSION ?= 0.9.8l
OPENLDAP_VERSION ?= 2.4.21

OPENSSL_LIB_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib
OPENLDAP_LIB_DIR ?= $(ZIVIOS_HOME)/openldap-$(OPENLDAP_VERSION)/lib

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/bind-$(BIND_VERSION).tar.gz; \
	cd bind-$(BIND_VERSION); \
	patch -p1 < ../patches/dlzfix01.patch; \
	LDFLAGS="-L$(OPENSSL_LIB_DIR) -Wl,-rpath,$(OPENSSL_LIB_DIR) -L$(OPENLDAP_LIB_DIR) -Wl,-rpath,$(OPENLDAP_LIB_DIR)" \
	LD_LIBRARY_PATH=$(OPENSSL_LIB_DIR):$(OPENLDAP_LIB_DIR) \
	CPPFLAGS="-I$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/include -I$(ZIVIOS_HOME)/openldap-$(OPENLDAP_VERSION)/include" \
	./configure --prefix=$(ZIVIOS_HOME)/bind-$(BIND_VERSION) \
	--sysconfdir=$(ZIVIOS_HOME)/bind-$(BIND_VERSION)/etc \
	--localstatedir=$(ZIVIOS_HOME)/bind-$(BIND_VERSION)/var \
	--enable-threads \
	--with-libtool \
	--with-openssl=$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION) \
	--with-dlz-ldap=$(ZIVIOS_HOME)/openldap-$(OPENLDAP_VERSION) \
	--enable-shared \
	--enable-static \
	--with-gnu-ld; \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(OPENLDAP_LIB_DIR) $(MAKE) $(MAKEARGS); LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(OPENLDAP_LIB_DIR) $(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s bind-$(BIND_VERSION) bind)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/isc-bind
	(cd $(ZIVIOS_HOME); tar czf $(BIND_TGZ_TARGET) bind-$(BIND_VERSION))

clean:
	/bin/rm -rf bind-$(BIND_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/bind-$(BIND_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/bind
