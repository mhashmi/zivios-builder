OPENLDAP_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(OPENLDAP_ROOT)/../..; pwd)
MAKE ?= make
MAKEARGS ?= -j2

BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ifeq ($(BUILD_PLATFORM), )
	BUILD_PLATFORM := "UNKNOWN"
endif

ZIVIOS_HOME ?= /opt/zivios
LDAP_VERSION ?= 2.4.21
LDAP_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/openldap/openldap-$(LDAP_VERSION).tgz

CYRUS_VERSION ?= 2.1.23
BDB_VERSION ?= 4.8.26
OPENSSL_VERSION ?= 0.9.8l

CYRUS_LIB_DIR ?= $(ZIVIOS_HOME)/cyrus-sasl-$(CYRUS_VERSION)/lib
BDB_LIB_DIR ?= $(ZIVIOS_HOME)/bdb-$(BDB_VERSION)/lib
OPENSSL_LIB_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib

all: build

build:
	(tar xzf src/openldap-$(LDAP_VERSION).tgz; \
	cd openldap-$(LDAP_VERSION); \
	LDFLAGS="-L$(OPENSSL_LIB_DIR) -Wl,-rpath,$(OPENSSL_LIB_DIR) -L$(BDB_LIB_DIR) -Wl,-rpath,$(BDB_LIB_DIR) -L$(CYRUS_LIB_DIR) -Wl,-rpath,$(CYRUS_LIB_DIR)" \
	LD_LIBRARY_PATH=$(OPENSSL_LIB_DIR):$(BDB_LIB_DIR):$(CYRUS_LIB_DIR) \
	CPPFLAGS="-D_GNU_SOURCE -I$(ZIVIOS_HOME)/bdb-$(BDB_VERSION)/include -I$(ZIVIOS_HOME)/cyrus-sasl-$(CYRUS_VERSION)/include -I$(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/include" \
	CFLAGS="-g -O0" \
	$(ENVMOD) ./configure --prefix=$(ZIVIOS_HOME)/openldap-$(LDAP_VERSION) \
	--with-cyrus-sasl \
	--with-tls \
	--enable-dynamic \
	--enable-slapd \
	--enable-modules \
	--enable-backends=mod \
		--disable-sql \
		--disable-ndb \
		--disable-perl \
	--enable-overlays=mod \
	--enable-debug \
	--enable-crypt \
	--enable-syslog \
	--enable-aci \
	--enable-local \
	--enable-slurpd=no; \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(BDB_LIB_DIR):$(CYRUS_LIB_DIR) $(MAKE) $(MAKEARGS); LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(BDB_LIB_DIR):$(CYRUS_LIB_DIR) $(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s openldap-$(LDAP_VERSION) openldap)

smbk5pwd: buildsmb tar

buildsmb:
	/bin/cp $(BUILD_ROOT)/software/openldap/Makefile.smbk5pwd $(BUILD_ROOT)/software/openldap/openldap-$(LDAP_VERSION)/contrib/slapd-modules/smbk5pwd/Makefile
	(cd $(BUILD_ROOT)/software/openldap/openldap-$(LDAP_VERSION)/contrib/slapd-modules/smbk5pwd; $(MAKE); \
	/bin/cp -a .libs/* $(ZIVIOS_HOME)/openldap-$(LDAP_VERSION)/libexec/openldap; /bin/rm $(ZIVIOS_HOME)/openldap-$(LDAP_VERSION)/libexec/openldap/smbk5pwd.la; \
	/bin/cp smbk5pwd.la $(ZIVIOS_HOME)/openldap-$(LDAP_VERSION)/libexec/openldap; /bin/rm $(ZIVIOS_HOME)/openldap-$(LDAP_VERSION)/libexec/openldap/smbk5pwd.lai; \
	/bin/rm $(ZIVIOS_HOME)/openldap-$(LDAP_VERSION)/libexec/openldap/smbk5pwd.o; /bin/chmod 0755 $(ZIVIOS_HOME)/openldap-$(LDAP_VERSION)/libexec/openldap/smbk5pwd.*)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/openldap
	(cd $(ZIVIOS_HOME); tar czf $(LDAP_TGZ_TARGET) openldap-$(LDAP_VERSION))

clean:
	/bin/rm -rf openldap-$(LDAP_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/openldap-$(LDAP_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/openldap
