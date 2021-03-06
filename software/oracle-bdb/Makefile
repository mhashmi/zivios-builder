MAKE ?= make
MAKEARGS ?= -j2
BDB_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(BDB_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
BDB_VERSION ?=  4.8.26
BDB_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/bdb/bdb-$(BDB_VERSION).tgz
BDB_LIB_DIR ?= $(ZIVIOS_HOME)/bdb-$(BDB_VERSION)/lib

ifeq ($(BUILD_PLATFORM), )
	BUILD_PLATFORM := "UNKNOWN"
endif

all: build tar

build:
	(tar xzf src/db-$(BDB_VERSION).tar.gz; \
	cd db-$(BDB_VERSION); \
	cd build_unix; \
	CFLAGS="-g -O2 -fPIC" \
	LD_RUN_PATH=$(BDB_LIB_DIR) \
	../dist/configure --prefix=$(ZIVIOS_HOME)/bdb-$(BDB_VERSION); \
	CFLAGS="-g -O2 -fPIC" \
	LD_RUN_PATH=$(BDB_LIB_DIR) \
	$(MAKE) $(MAKEARGS) CFLAGS="-g -O2 -fPIC"; LD_RUN_PATH=$(BDB_LIB_DIR) $(MAKE) install)
	(cd $(ZIVIOS_HOME); ln -s bdb-$(BDB_VERSION) bdb)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/bdb
	(cd $(ZIVIOS_HOME); tar czf $(BDB_TGZ_TARGET) bdb-$(BDB_VERSION))

clean:
	/bin/rm -rf db-$(BDB_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/bdb-$(BDB_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/bdb
