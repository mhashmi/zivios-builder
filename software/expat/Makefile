MAKE ?= make
MAKEARGS ?= -j2
EXPAT_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(EXPAT_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
EXPAT_VERSION ?= 2.0.1
EXPAT_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/expat/expat-$(EXPAT_VERSION).tgz
EXPAT_SOURCE := $(EXPAT_ROOT)/expat-$(EXPAT_VERSION)

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/expat-$(EXPAT_VERSION).tar.gz; \
	cd expat-$(EXPAT_VERSION); \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/expat-$(EXPAT_VERSION) \
		--enable-shared=no \
		--enable-static=yes; \
	$(MAKE) $(MAKEARGS); $(MAKE) install)
	(cd $(ZIVIOS_HOME); ln -s expat-$(EXPAT_VERSION) expat)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/expat
	(cd $(ZIVIOS_HOME); tar czf $(EXPAT_TGZ_TARGET) expat-$(EXPAT_VERSION))

clean:
	/bin/rm -rf expat-$(EXPAT_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/expat-$(EXPAT_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/expat
