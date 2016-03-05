MAKE ?= make
PHPSSH_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(PHPSSH_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
PHPSSH_VERSION ?= 0.10
PHPSSH_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/phpssh/ssh2-$(PHPSSH_VERSION).tgz
PHPSSH_SOURCE := $(PHPSSH_ROOT)/ssh2-$(PHPSSH_VERSION)

LIBSSH_VERSION ?= 0.14
LIBSSH_LIB_DIR ?= $(ZIVIOS_HOME)/libssh2-$(LIBSSH_VERSION)/lib

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build notice

build:
	(tar xzf src/ssh2-$(PHPSSH_VERSION).tgz; \
	cd ssh2-$(PHPSSH_VERSION); \
	phpize; \
	./configure \
	--with-lib-dir=$(LIBSSH_LIB_DIR) \
	--with-ssh2=$(ZIVIOS_HOME)/libssh2-$(LIBSSH_VERSION); \
	$(MAKE));

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/phpssh
	(cd $(ZIVIOS_HOME); tar czf $(PHPSSH_TGZ_TARGET) phpssh-$(PHPSSH_VERSION))

clean:
	/bin/rm -rf ssh2-$(PHPSSH_VERSION)
	/bin/rm -f package.xml

allclean: clean

notice:
	@echo "\n################## NOTE #####################\n";
	@echo "The ssh2 module is available under ssh2-$(PHPSSH_VERSION)/modules\n";
	@echo "You can run make install manually to check install target and package\n";
	@echo "the module as required.\n";

