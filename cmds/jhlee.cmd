require ADSpinnaker,2.0.0
require calc,3.7.3
require busy,1.7.2-e45eda2
require autosave,5.10.0

epicsEnvSet("TOP", "$(E3_CMD_TOP)/..")

epicsEnvSet("CAMERA_ID", "19299225")


epicsEnvSet("AREA", "labs-utg-test")
epicsEnvSet("DEVICE", "cam1")

epicsEnvSet("PREFIX", "$(AREA):$(DEVICE):")
epicsEnvSet("IOCNAME", "$(AREA)-$(DEVICE)")
epicsEnvSet("IMAGE", "Image1")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","64000000")

### The port name for the detector
epicsEnvSet("PORT",   "PG")
#-## Really large queue so we can stream to disk at full camera speed
epicsEnvSet("QSIZE",  "2000")   
#-## The maximim image width; used for row profiles in the NDPluginStats plugin
epicsEnvSet("XSIZE",  "2448")
#-## The maximim image height; used for column profiles in the NDPluginStats plugin
epicsEnvSet("YSIZE",  "2048")
#-## The maximum number of time series points in the NDPluginStats plugin
epicsEnvSet("NCHANS", "2048")
#-## The maximum number of frames buffered in the NDPluginCircularBuff plugin
epicsEnvSet("CBUFFS", "500")

epicsEnvSet("NELEMENTS", "12592912")

# Define all requestfile paths 
set_requestfile_path("$(ADSpinnaker_DB)", "")
set_requestfile_path("$(ADGenICam_DB)", "")
set_requestfile_path("$(ADCore_DB)", "")
set_requestfile_path("$(calc_DB)", "")
set_requestfile_path("$(busy_DB)", "")
set_requestfile_path("$(TOP)", "cmds")

#-
ADSpinnakerConfig("$(PORT)", "$(CAMERA_ID)", 0x1, 0)
dbLoadRecords("spinnaker.db", "P=$(PREFIX),R=,PORT=$(PORT)")
dbLoadRecords("PGR_BlackflyS_50S5C.db", "P=$(PREFIX),R=,PORT=$(PORT)")

# Create a standard arrays plugin
NDStdArraysConfigure("$(IMAGE)", 5, 0, "$(PORT)", 0, 0)
dbLoadRecords("NDStdArrays.template", "P=$(PREFIX),R=,PORT=$(IMAGE),ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),TYPE=Int16,FTVL=SHORT,NELEMENTS=$(NELEMENTS)")
# Load the commPlugins.iocsh for ADCore
iocshLoad("$(ADCore_DIR)/commPlugins.iocsh", "P=$(PREFIX),UNIT=1,PORT=$(IMAGE),QSIZE=$(QSIZE),XSIZE=$(XSIZE),YSIZE=$(YSIZE),NCHANS=$(NCHANS),CBUFFS=$(CBUFFS)")

# Load autosave iocsh
iocshLoad("$(autosave_DIR)/autosave.iocsh", "AS_TOP=$(TOP),IOCNAME=$(IOCNAME)")

#
iocInit()

create_monitor_set("auto_settings.req", 5, "P=$(PREFIX),R=,IMAGE=$(IMAGE):")
#create_monitor_set("$(TOP)/cmds/auto_settings.req", 5, "P=$(PREFIX),R=,IMAGE=$(IMAGE):")
# Wait for enum callbacks to complete
epicsThreadSleep(2.0)
# Wait for callbacks on the property limits (DRVL, DRVH) to complete
epicsThreadSleep(2.0)


#dbl > "${IOCNAME}_PVs.list"
