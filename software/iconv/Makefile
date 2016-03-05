MAKE ?= make
MAKEARGS ?= -j2
ICONV_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(ICONV_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
ICONV_VERSION ?= 1.13.1
ICONV_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/iconv/iconv-$(ICONV_VERSION).tgz
ICONV_SOURCE := $(ICONV_ROOT)/iconv-$(ICONV_VERSION)

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/libiconv-$(ICONV_VERSION).tar.gz; \
	cd libiconv-$(ICONV_VERSION); \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/iconv-$(ICONV_VERSION) \
		--enable-shared=no \
		--enable-static=yes \
		--disable-nls; \
	$(MAKE) $(MAKEARGS); $(MAKE) install)
	(cd $(ZIVIOS_HOME); ln -s iconv-$(ICONV_VERSION) iconv)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/iconv
	(cd $(ZIVIOS_HOME); tar czf $(ICONV_TGZ_TARGET) iconv-$(ICONV_VERSION))

clean:
	/bin/rm -rf libiconv-$(ICONV_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/iconv-$(ICONV_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/iconv
