ZVPANEL_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(ZVPANEL_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
ZVPANEL_VERSION ?=  0.6.3
ZVPANEL_SOURCE := $(ZVPANEL_ROOT)/zvpanel-$(ZVPANEL_VERSION)
ZVPANEL_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/zvpanel/zvpanel-$(ZVPANEL_VERSION).tgz

all: build tar

build: 
	tar xzf src/zvpanel-$(ZVPANEL_VERSION).tgz
	cp -R zvpanel-$(ZVPANEL_VERSION) $(ZIVIOS_HOME)
	(cd $(ZIVIOS_HOME); ln -s zvpanel-$(ZVPANEL_VERSION) zvpanel)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/zvpanel
	(cd $(ZIVIOS_HOME); tar czf $(ZVPANEL_TGZ_TARGET) zvpanel-$(ZVPANEL_VERSION))

platform:
	echo $(BUILD_PLATFORM);

clean:
	/bin/rm -rf zvpanel-$(ZVPANEL_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/zvpanel-$(ZVPANEL_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/zvpanel
