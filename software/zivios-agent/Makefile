ZVAGENT_ROOT := $(shell pwd)
BUILD_ROOT ?= $(shell cd $(ZVAGENT_ROOT)/../..; pwd)
BUILD_PLATFORM ?= $(shell sh $(BUILD_ROOT)/buildhelpers/platform.sh distroarch)

ZIVIOS_HOME ?= /opt/zivios
ZVAGENT_VERSION ?=  0.6.3
ZVAGENT_SOURCE := $(ZVAGENT_ROOT)/zivios-agent-$(ZVAGENT_VERSION)
ZVAGENT_TGZ_TARGET := $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/zivios-agent/zivios-agent-$(ZVAGENT_VERSION).tgz

all: build tar

build: 
	tar xzf src/zivios-agent-$(ZVAGENT_VERSION).tgz
	cp -R zivios-agent-$(ZVAGENT_VERSION) $(ZIVIOS_HOME)
	(cd $(ZIVIOS_HOME); ln -s zivios-agent-$(ZVAGENT_VERSION) zivios-agent)

tar:
	mkdir -p $(BUILD_ROOT)/packagebuilds/$(BUILD_PLATFORM)/zivios-agent
	(cd $(ZIVIOS_HOME); tar czf $(ZVAGENT_TGZ_TARGET) zivios-agent-$(ZVAGENT_VERSION))

platform:
	echo $(BUILD_PLATFORM);

clean:
	/bin/rm -rf zivios-agent-$(ZVAGENT_VERSION)

allclean: clean
	/bin/rm -rf $(ZIVIOS_HOME)/zivios-agent-$(ZVAGENT_VERSION)
	/bin/rm -rf $(ZIVIOS_HOME)/zivios-agent
