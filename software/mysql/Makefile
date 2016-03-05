MAKE ?= make
MAKEARGS ?= 
MYSQL_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(MYSQL_ROOT)/../..; pwd)
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
MYSQL_VERSION ?= 5.1.44
MYSQL_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/mysql/mysql-$(MYSQL_VERSION).tgz
MYSQL_SOURCE := $(MYSQL_ROOT)/mysql-$(MYSQL_VERSION)

OPENSSL_VERSION ?= 0.9.8l
OPENSSL_BASE_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)
OPENSSL_LIB_DIR ?= $(ZIVIOS_HOME)/openssl-$(OPENSSL_VERSION)/lib
OPENSSL_INC_DIR ?= $(OPENSSL_BASE_DIR)/include

ZLIB_VERSION ?= 1.2.3
ZLIB_BASE_DIR ?= $(ZIVIOS_HOME)/zlib-$(ZLIB_VERSION)
ZLIB_LIB_DIR ?= $(ZLIB_BASE_DIR)/lib
ZLIB_INC_DIR ?= $(ZLIB_BASE_DIR)/include

NCURSES_VERSION ?= 5.7
NCURSES_BASE_DIR ?= $(ZIVIOS_HOME)/ncurses-$(NCURSES_VERSION)
NCURSES_LIB_DIR ?= $(NCURSES_BASE_DIR)/lib
NCURSES_INC_DIR ?= $(NCURSES_BASE_DIR)/include

ifeq ($(BUILD_PLATFORM), )
        BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/mysql-$(MYSQL_VERSION).tar.gz; \
	cd mysql-$(MYSQL_VERSION); \
	LDFLAGS="-L$(OPENSSL_LIB_DIR) -L$(ZLIB_LIB_DIR)" \
	LD_LIBRARY_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR) \
	CPPFLAGS="-I$(OPENSSL_INC_DIR) -I$(ZLIB_INC_DIR)" \
	CFLAGS="-fPIC" \
	./configure --prefix=$(ZIVIOS_HOME)/mysql-$(MYSQL_VERSION) \
	--enable-thread-safe-client \
	--enable-static=yes \
	--enable-shared=no \
	--with-zlib-dir=$(ZLIB_BASE_DIR) \
	--with-ssl=$(OPENSSL_BASE_DIR) \
	--without-debug \
	--without-server \
	--without-man \
	--without-docs \
	--with-named-curses-libs=$(NCURSES_LIB_DIR)/libncurses.a; \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR) $(MAKE) $(MAKEARGS); \
	LD_RUN_PATH=$(OPENSSL_LIB_DIR):$(ZLIB_LIB_DIR) $(MAKE) install STRIP="")
	(cd $(ZIVIOS_HOME); ln -s mysql-$(MYSQL_VERSION) mysql)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/mysql
	(cd $(ZIVIOS_HOME); tar czf $(MYSQL_TGZ_TARGET) mysql-$(MYSQL_VERSION))

clean:
	/bin/rm -rf mysql-$(MYSQL_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/mysql-$(MYSQL_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/mysql

plat:
	@echo "Platform is $(PLAT)"
