
e3-ADSpinnaker  
======
ESS Site-specific EPICS module : ADSpinnaker

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
