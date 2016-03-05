MAKE ?= make
MAKEARGS ?= 
READLINE_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(READLINE_ROOT)/../..; pwd)
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
READLINE_VERSION ?= 6.1
READLINE_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/readline/readline-$(READLINE_VERSION).tgz
READLINE_SOURCE := $(READLINE_ROOT)/readline-$(READLINE_VERSION)

NCURSES_VERSION ?= 5.7
NCURSES_BASE_DIR ?= $(ZIVIOS_HOME)/ncurses-$(NCURSES_VERSION)
NCURSES_LIB_DIR ?= $(NCURSES_BASE_DIR)/lib
NCURSES_INC_DIR ?= $(NCURSES_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/readline-$(READLINE_VERSION).tar.gz; \
	cd readline-$(READLINE_VERSION); \
	LDFLAGS="-L$(NCURSES_LIB_DIR)" \
        LD_LIBRARY_PATH=$(NCURSES_LIB_DIR) \
	CFLAGS="-fPIC" \
        CPPFLAGS="-I$(NCURSES_INC_DIR)" \
	./configure --prefix=$(ZIVIOS_HOME)/readline-$(READLINE_VERSION) \
	--with-curses=$(NCURSES_BASE_DIR) \
	--enable-shared=no \
	--enable-static=yes; \
	$(MAKE) $(MAKEARGS); \
	$(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s readline-$(READLINE_VERSION) readline)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/readline
	(cd $(ZIVIOS_HOME); tar czf $(READLINE_TGZ_TARGET) readline-$(READLINE_VERSION))

clean:
	/bin/rm -rf readline-$(READLINE_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/readline-$(READLINE_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/readline

plat:
	@echo "Platform is $(PLAT)"
