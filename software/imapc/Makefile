MAKE ?= make
MAKEARGS ?= 'ANSIFLAGS='
IMAPC_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(IMAPC_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)
BUILD_FOR ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distro | tr 'A-Z' 'a-z')

ifeq ($(BUILD_FOR), )
	@echo "Could not determine distribution... exiting"
	exit 1
endif

ifeq ($(BUILD_FOR), debian)
	DISTRO := ldb
endif

ifeq ($(BUILD_FOR), ubuntu)
	DISTRO := ldb
endif

ifeq ($(BUILD_FOR), centos)
	DISTRO := lr5
endif

ifeq ($(BUILD_FOR), redhat)
	DISTRO := lr5
endif

ifeq ($(DISTRO), )
	@echo "Makefile missing distro support. Please add it and try again.";
	exit 1
endif

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
IMAPC_VERSION ?= 2007e
IMAPC_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/imapc/imapc-$(IMAPC_VERSION).tgz
IMAPC_BASE_DIR := $(ZIVIOS_HOME)/imapc-$(IMAPC_VERSION)
IMAPC_LIB_DIR := $(IMAPC_BASE_DIR)/lib
IMAPC_INC_DIR := $(IMAPC_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), )
	BUILD_PLATFORM := "UNKNOWN"
endif

all: cfolders build tar

cfolders:
	rm -rf $(IMAPC_BASE_DIR)
	mkdir $(IMAPC_BASE_DIR)
	mkdir $(IMAPC_LIB_DIR)
	mkdir $(IMAPC_INC_DIR)

build:
	(tar xzf src/imap.tar.gz; \
	cd imap-$(IMAPC_VERSION); \
	../patch.sh; \
	$(MAKE) $(DISTRO) "EXTRACFLAGS = -fPIC" "EXTRASPECIALS = cc=gcc" "IP6=4"; \
	cp c-client/*.h $(IMAPC_INC_DIR)/; \
	cp c-client/c-client.a $(IMAPC_LIB_DIR)/libc-client.a)
	(cd $(ZIVIOS_HOME); ln -s imapc-$(IMAPC_VERSION) imapc)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/imapc
	(cd $(ZIVIOS_HOME); tar czf $(IMAPC_TGZ_TARGET) imapc-$(IMAPC_VERSION))

clean:
	/bin/rm -rf imap-$(IMAPC_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/imapc-$(IMAPC_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/imapc

plat:
	@echo "Platform is $(PLAT)"
