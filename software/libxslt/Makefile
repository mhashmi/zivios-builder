MAKE ?= make
MAKEARGS ?= 
LIBXSLT_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(LIBXSLT_ROOT)/../..; pwd)
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
LIBXSLT_VERSION ?= 1.1.26
LIBXSLT_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libxslt/libxslt-$(LIBXSLT_VERSION).tgz
LIBXSLT_SOURCE := $(LIBXSLT_ROOT)/libxslt-$(LIBXSLT_VERSION)

LIBXML2_VERSION ?= 2.7.6
LIBXML2_BASE_DIR ?= $(ZIVIOS_HOME)/libxml2-$(LIBXML2_VERSION)
LIBXML2_LIB_DIR ?= $(LIBXML2_BASE_DIR)/lib
LIBXML2_INC_DIR ?= $(LIBXML2_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/libxslt-$(LIBXSLT_VERSION).tar.gz; \
	cd libxslt-$(LIBXSLT_VERSION); \
	LDFLAGS="-L$(LIBXML2_LIB_DIR)" \
	LD_LIBRARY_PATH=$(LIBXML2_LIB_DIR) \
	CPPFLAGS="-I$(LIBXML2_INC_DIR)" \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/libxslt-$(LIBXSLT_VERSION) \
	--disable-shared \
	--enable-static \
	--with-libxml-prefix=$(LIBXML2_BASE_DIR) \
	--without-python; \
	LD_RUN_PATH=$(LIBXML2_LIB_DIR) $(MAKE) $(MAKEARGS); \
	LD_RUN_PATH=$(LIBXML2_LIB_DIR) $(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s libxslt-$(LIBXSLT_VERSION) libxslt)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/libxslt
	(cd $(ZIVIOS_HOME); tar czf $(LIBXSLT_TGZ_TARGET) libxslt-$(LIBXSLT_VERSION))

clean:
	/bin/rm -rf libxslt-$(LIBXSLT_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/libxslt-$(LIBXSLT_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/libxslt

plat:
	@echo "Platform is $(PLAT)"
