MAKE ?= make
MAKEARGS ?= 
GETTEXT_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(GETTEXT_ROOT)/../..; pwd)
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
GETTEXT_VERSION ?= 0.17
GETTEXT_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/gettext/gettext-$(GETTEXT_VERSION).tgz
GETTEXT_SOURCE := $(GETTEXT_ROOT)/gettext-$(GETTEXT_VERSION)

LIBXML2_VERSION ?= 2.7.6
LIBXML2_BASE_DIR ?= $(ZIVIOS_HOME)/libxml2-$(LIBXML2_VERSION)
LIBXML2_LIB_DIR ?= $(LIBXML2_BASE_DIR)/lib
LIBXML2_INC_DIR ?= $(LIBXML2_BASE_DIR)/include

ICONV_VERSION ?= 1.13.1
ICONV_BASE_DIR ?= $(ZIVIOS_HOME)/iconv-$(ICONV_VERSION)
ICONV_LIB_DIR ?= $(ICONV_BASE_DIR)/lib
ICONV_INC_DIR ?= $(ICONV_BASE_DIR)/include

NCURSES_VERSION ?= 5.7
NCURSES_BASE_DIR ?= $(ZIVIOS_HOME)/ncurses-$(NCURSES_VERSION)
NCURSES_LIB_DIR ?= $(ZLIB_BASE_DIR)/lib
NCURSES_INC_DIR ?= $(ZLIB_BASE_DIR)/include

EXPAT_VERSION ?= 2.0.1
EXPAT_BASE_DIR ?= $(ZIVIOS_HOME)/expat-$(EXPAT_VERSION)
EXPAT_LIB_DIR ?= $(EXPAT_BASE_DIR)/lib
EXPAT_INC_DIR ?= $(EXPAT_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/gettext-$(GETTEXT_VERSION).tar.gz; \
	cd gettext-$(GETTEXT_VERSION); \
	LDFLAGS="-L$(LIBXML2_LIB_DIR) -L$(EXPAT_LIB_DIR) -L$(NCURSES_LIB_DIR) -L$(ICONV_LIB_DIR)" \
	LD_LIBRARY_PATH=$(LIBXML2_LIB_DIR):$(EXPAT_LIB_DIR):$(NCURSES_LIB_DIR):$(ICONV_LIB_DIR) \
	CPPFLAGS="-I$(LIBXML2_INC_DIR) -I$(ICONV_INC_DIR) -I$(NCURSES_INC_DIR) -I$(EXPAT_INC_DIR)" \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/gettext-$(GETTEXT_VERSION) \
	--enable-static=yes \
	--enable-shared=no \
	--with-libiconv-prefix=$(ICONV_BASE_DIR) \
	--with-libexpat-prefix=$(EXPAT_BASE_DIR) \
	--with-libnurses-prefix=$(NCURSES_BASE_DIR) \
	--with-libxml2-prefix=$(LIBXML2_BASE_DIR) \
	--with-included-glib \
	--with-included-libcroco \
	--disable-libasprintf \
	--with-included-gettext; \
	LD_RUN_PATH=$(LIBXML2_LIB_DIR):$(ICONV_LIB_DIR):$(NCURSES_LIB_DIR):$(EXPAT_LIB_DIR) $(MAKE) $(MAKEARGS); \
	LD_RUN_PATH=$(LIBXML2_LIB_DIR):$(ICONV_LIB_DIR):$(NCURSES_LIB_DIR):$(EXPAT_LIB_DIR) $(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s gettext-$(GETTEXT_VERSION) gettext)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/gettext
	(cd $(ZIVIOS_HOME); tar czf $(GETTEXT_TGZ_TARGET) gettext-$(GETTEXT_VERSION))

clean:
	/bin/rm -rf gettext-$(GETTEXT_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/gettext-$(GETTEXT_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/gettext

plat:
	@echo "Platform is $(PLAT)"
