#
#  Copyright (c) 2019    European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Monday, September 16 09:24:28 CEST 2019
# version : 0.0.3
#
# The following lines are mandatory, please don't change them.
where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(E3_REQUIRE_TOOLS)/driver.makefile
include $(E3_REQUIRE_CONFIG)/DECOUPLE_FLAGS


ifneq ($(strip $(ASYN_DEP_VERSION)),)
asyn_VERSION=$(ASYN_DEP_VERSION)
endif


ifneq ($(strip $(ADCORE_DEP_VERSION)),)
ADCore_VERSION=$(ADCORE_DEP_VERSION)
endif


ifneq ($(strip $(ADGENICAM_DEP_VERSION)),)
ADGenICam_VERSION=$(ADGENICAM_DEP_VERSION)
endif



## Exclude linux-ppc64e6500
EXCLUDE_ARCHS = linux-ppc64e6500
EXCLUDE_ARCHS += linux-corei7-poky

APPNAME:=spinnaker
SUPPORT:=$(APPNAME)Support
APP:=$(APPNAME)App
APPDB:=$(APP)/Db
APPSRC:=$(APP)/src


USR_INCLUDES += -I$(where_am_I)$(SUPPORT)/include
USR_CXXFLAGS_Linux += -D LINUX
USR_CXXFLAGS_Linux += -std=c++11 -Wno-unknown-pragmas

# Ubuntu needs the following ldflags
USR_LDFLAGS += -Wl,--no-as-needed


SOURCES += $(APPSRC)/SPFeature.cpp
SOURCES += $(APPSRC)/ADSpinnaker.cpp

DBDS += $(APPSRC)/ADSpinnakerSupport.dbd

ifeq ($(SUPPORT_EXTERNAL),NO)
USR_LDFLAGS  += -Wl,--enable-new-dtags
USR_LDFLAGS  += -Wl,-rpath=$(E3_MODULES_VENDOR_LIBS_LOCATION)
USR_LDFLAGS  += -L$(E3_MODULES_VENDOR_LIBS_LOCATION)
LIB_SYS_LIBS += Spinnaker
LIB_SYS_LIBS += GCBase_gcc540_v3_0
LIB_SYS_LIBS += GenApi_gcc540_v3_0
LIB_SYS_LIBS += Log_gcc540_v3_0
LIB_SYS_LIBS += MathParser_gcc540_v3_0
LIB_SYS_LIBS += NodeMapData_gcc540_v3_0
LIB_SYS_LIBS += XmlParser_gcc540_v3_0

# According to its makefile
VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libSpinnaker.so
VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libSpinnaker.so.1
VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libSpinnaker.so.1.20.0.14
VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libGenApi_gcc540_v3_0.so
VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libGCBase_gcc540_v3_0.so
VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libLog_gcc540_v3_0.so
VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libMathParser_gcc540_v3_0.so
VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libNodeMapData_gcc540_v3_0.so
VENDOR_LIBS += $(SUPPORT)/os/linux-x86_64/libXmlParser_gcc540_v3_0.so
else
LIB_SYS_LIBS += Spinnaker
LIB_SYS_LIBS += GCBase_gcc540_v3_0
LIB_SYS_LIBS += GenApi_gcc540_v3_0
LIB_SYS_LIBS += Log_gcc540_v3_0
LIB_SYS_LIBS += MathParser_gcc540_v3_0
LIB_SYS_LIBS += NodeMapData_gcc540_v3_0
LIB_SYS_LIBS += XmlParser_gcc540_v3_0
USR_INCLUDES += -I/usr/include
endif # ($(SUPPORT_EXTERNAL),NO)


SCRIPTS += $(wildcard ../iocsh/*.iocsh)


db: 

.PHONY: db 


USR_DBFLAGS += -I . -I ..
USR_DBFLAGS += -I $(EPICS_BASE)/db
USR_DBFLAGS += -I $(APPDB)

USR_DBFLAGS += -I $(E3_SITEMODS_PATH)/ADCore/$(ADCORE_DEP_VERSION)/db
USR_DBFLAGS += -I $(E3_SITEMODS_PATH)/ADGenICam/$(ADGENICAM_DEP_VERSION)/db

SUBS=$(wildcard $(APPDB)/*.substitutions)
TMPS=$(wildcard $(APPDB)/*.template)

db: $(SUBS) $(TMPS)

$(SUBS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db -S $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db -S $@

$(TMPS):
	@printf "Inflating database ... %44s >>> %40s \n" "$@" "$(basename $(@)).db"
	@rm -f  $(basename $(@)).db.d  $(basename $(@)).db
	@$(MSI) -D $(USR_DBFLAGS) -o $(basename $(@)).db $@  > $(basename $(@)).db.d
	@$(MSI)    $(USR_DBFLAGS) -o $(basename $(@)).db $@


.PHONY: db $(SUBS) $(TMPS)

vlibs: $(VENDOR_LIBS)

$(VENDOR_LIBS):
ifeq ($(SUPPORT_EXTERNAL),NO)
	$(QUIET)$(SUDO) install -m 755 -d $(E3_MODULES_VENDOR_LIBS_LOCATION)/
	$(QUIET)$(SUDO) install -m 755 $@ $(E3_MODULES_VENDOR_LIBS_LOCATION)/
endif

.PHONY: $(VENDOR_LIBS) vlibs



