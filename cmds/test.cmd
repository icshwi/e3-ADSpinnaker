require ADSpinnaker,2.0.0

epicsEnvSet("CAMERA_ID", "19299225")
epicsEnvSet("PORT",   "PG")

ADSpinnakerConfig("$(PORT)", 19299225, 0x1, 0)

iocInit()
