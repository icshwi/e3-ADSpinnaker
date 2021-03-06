# Deprecation notice

2020-08-20: This remote has been deprecated. Moved to https://gitlab.esss.lu.se/e3/area/e3-ADSpinnaker.


e3-ADSpinnaker  
======
ESS Site-specific EPICS module : ADSpinnaker

## Spinnaker Libraries

* With the default shared libraries within spinnakerSupport and its header files return the following error messages:

```
ADSpinnakerConfig("PG", 19299225, 0x1, 0)                                                                                      
terminate called after throwing an instance of 'Spinnaker::Exception'                                                          
  what():  Spinnaker: System instance cannot be acquired. [-1012]    
```

in `Ubuntu 18.04.3 LTS (GNU/Linux 5.0.0-27-generic x86_64)`

* The latest (current) SpinnakerSDK is 1.26.0.31 in [1]. And one should install the following packages
  - `libspinnaker-1.26.0.31_amd64-dev.deb`
  - `libspinnaker-1.26.0.31_amd64.de`
  - `libspinnaker-c-1.26.0.31_amd64.deb`
  - `libspinnaker-c-1.26.0.31_amd64-dev.deb`

* If one would like to switch between SpinnakerSDK and areaDetector libraries, one can use `SUPPORT_EXTERNAL` defined in
`configure/CONFIG_OPTIONS`

  - AreaDetector : `echo "SUPPORT_EXTERNAL:=NO" > configure/CONFIG_OPTIONS.local`
  - SpinnakerSDK : Default one


## OS

We cannot use this on CentOS7 based system, I think, we can do in CentOS8 in near future, because of 
```
/lib64/libm.so.6: version `GLIBC_2.27' not found
/lib64/libc.so.6: version `GLIBC_2.27' not found (required by libSpinnaker.so.1)
/lib64/libstdc++.so.6: version `CXXABI_1.3.8' not found (required by libSpinnaker.so.1)
/lib64/libstdc++.so.6: version `CXXABI_1.3.9' not found (required by libSpinnaker.so.1)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found (required by libSpinnaker.so.1)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by libSpinnaker.so.1)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found (required by libGCBase_gcc540_v3_0.so)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by libGCBase_gcc540_v3_0.so)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found (required by libGenApi_gcc540_v3_0.so)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by libGenApi_gcc540_v3_0.so)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by libXmlParser_gcc540_v3_0.so)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by libLog_gcc540_v3_0.so)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.20' not found (required by libNodeMapData_gcc540_v3_0.so)
/lib64/libstdc++.so.6: version `GLIBCXX_3.4.21' not found (required by libNodeMapData_gcc540_v3_0.so)
```


## Reference
[1] https://flir.app.boxcn.net/v/SpinnakerSDK/folder/74729115388 

  
