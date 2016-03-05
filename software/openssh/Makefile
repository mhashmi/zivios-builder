MAKE ?= make
MAKEARGS ?= 
SSH_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(SSH_ROOT)/../..; pwd)
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
SSH_VERSION ?= 5.2p1
SSH_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/openssh/openssh-$(SSH_VERSION).tgz
SSH_SOURCE := $(SSH_ROOT)/openssh-$(SSH_VERSION)

OPENSSL_VERSION ?= 0.9.8k
OPENSSL_BASE_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)
OPENSSL_LIB_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib
OPENSSL_INC_DIR ?= $(OPENSSL_BASE_DIR)/include

ZLIB_VERSION ?= 1.2.3
ZLIB_BASE_DIR ?= $(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION)
ZLIB_LIB_DIR ?= $(ZLIB_BASE_DIR)/lib
ZLIB_INC_DIR ?= $(ZLIB_BASE_DIR)/include


ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/openssh-$(SSH_VERSION).tar.gz; \
	cd openssh-$(SSH_VERSION); \
	LDFLAGS="-L$(OPENSSL_LIB_DIR) -L$(ZLIB_LIB_DIR)" \
	LD_LIBRARY_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR) \
	CPPFLAGS="-I$(OPENSSL_INC_DIR) -I$(ZLIB_INC_DIR)" \
	./configure --prefix=$(ZIVIOS_HOME)/openssh-$(SSH_VERSION) \
	--with-zlib=$(ZLIB_BASE_DIR) \
	--with-ssl=$(OPENSSL_BASE_DIR); \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR) $(MAKE) $(MAKEARGS); \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR) $(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s openssh-$(SSH_VERSION) openssh)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/openssh
	(cd $(ZIVIOS_HOME); tar czf $(SSH_TGZ_TARGET) openssh-$(SSH_VERSION))

clean:
	/bin/rm -rf openssh-$(SSH_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/openssh-$(SSH_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/openssh

plat:
	@echo "Platform is $(PLAT)"
