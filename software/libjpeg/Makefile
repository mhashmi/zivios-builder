MAKE ?= make
MAKEARGS ?= 
JPEG_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(JPEG_ROOT)/../..; pwd)
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
JPEG_VERSION ?= 8
JPEG_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libjpeg/jpeg-$(JPEG_VERSION).tgz
JPEG_SOURCE := $(JPEG_ROOT)/jpeg-$(JPEG_VERSION)

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/jpegsrc.v$(JPEG_VERSION).tar.gz; \
	cd jpeg-$(JPEG_VERSION); \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/libjpeg-$(JPEG_VERSION) \
	--enable-static=yes \
	--enable-shared=no; \
	$(MAKE) $(MAKEARGS); \
	$(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s libjpeg-$(JPEG_VERSION) libjpeg)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libjpeg
	(cd $(ZIVIOS_HOME); tar czf $(JPEG_TGZ_TARGET) libjpeg-$(JPEG_VERSION))

clean:
	/bin/rm -rf jpeg-$(JPEG_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/libjpeg-$(JPEG_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/libjpeg

plat:
	@echo "Platform is $(PLAT)"
