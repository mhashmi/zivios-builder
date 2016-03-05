MAKE ?= make
MAKEARGS ?=
PCRE_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(PCRE_ROOT)/../..; pwd)
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
PCRE_VERSION ?= 8.01
PCRE_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/pcre/pcre-$(PCRE_VERSION).tgz

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/pcre-$(PCRE_VERSION).tar.gz; \
	cd pcre-$(PCRE_VERSION); \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/pcre-$(PCRE_VERSION) \
	--enable-static=yes \
	--enable-shared=no; \
	$(MAKE) $(MAKEARGS); \
	$(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s pcre-$(PCRE_VERSION) pcre)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/pcre
	(cd $(ZIVIOS_HOME); tar czf $(PCRE_TGZ_TARGET) pcre-$(PCRE_VERSION))

clean:
	/bin/rm -rf pcre-$(PCRE_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/pcre-$(PCRE_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/pcre

plat:
	@echo "Platform is $(PLAT)"
