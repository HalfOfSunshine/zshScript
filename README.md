---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: true

print_background: true
---
<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [zshScript](#zshscript)
  - [介绍](#介绍)
    - [jailbreak ：逆向相关](#jailbreakscriptsjailbreak-逆向相关)
    - [pod : CocoaPods](#podscriptspod--cocoapods)
    - [work ：工作相关](#workscriptswork-工作相关)
    - [other：其他](#otherscriptsother其他)

<!-- /code_chunk_output -->


# zshScript

## 介绍
整理一些自己用过的的脚本文件
运行环境：mac ， zsh

### [jailbreak](Scripts/jailbreak) ：逆向相关
[tweak](Scripts/jailbreak/tweak.sh) ：打包安装tewak插件

[tweak_release](Scripts/jailbreak/tweak_release.sh) ：打包安装tewak插件,release模式

[dumpIPA](Scripts/jailbreak/dumpIPA.sh) ：dump，使用frida ，使用：```sh dumpIPA.sh 微博```

[usb](Scripts/jailbreak/usb.sh)：使用usbmuxd连接到手机，端口映射为：22:10010

[login](Scripts/jailbreak/login.sh) ：通过10010端口登陆root用户

[debug+usb](Scripts/jailbreak/debug+usb.sh) ：开启多个端口：[usb](Scripts/jailbreak/usb.sh)+调试端口1234:1234

[usb_debugserver](Scripts/jailbreak/usb_debugserver.sh) ：开启多个端口：[usb](Scripts/jailbreak/usb.sh)+调试端口10011:10011

### [pod](Scripts/pod) : CocoaPods
[pod_trunk_push](Scripts/pod/pod_trunk_push.sh) ：
更新sdk，需要cd到.spec所在文件夹下。
直接读取当前路径下的.podspec文件，并将其中的s.version 字段作为版本号，自动给github项目打tag，并将发布pod版本。
使用：
```
cd SDKProj
sh ~/pod_trunk_push.sh
```
[pod_trunk_delete](Scripts/pod/pod_trunk_delete.sh)：
删除版本，与pod_trunk_push相反。需要cd到.spec所在文件夹下，需要输入要删除的版本号。
使用：
```
cd SDKProj
sh ~/pod_trunk_delete.sh 1.0.0
```
### [work](Scripts/work) ：工作相关
[ZJSDK_arrangeDemo](Scripts/work/ZJSDK_arrangeDemo.sh) ：制作手动上传需要的demo，删除不必要的文件，添加依赖的本地三方库
[IPDSDK_arrangeDemo](Scripts/work/IPDSDK_arrangeDemo.sh) ：制作手动上传需要的demo，删除不必要的文件，添加依赖的本地三方库
### [other](Scripts/other)：其他

[remove_duplicates](Scripts/other/remove_duplicates.sh)：
删除当前文件夹下所有子文件夹下重复的文件。
    ---如果同时存在a.xx,a(1).xx且两者大小相等，则删除a(1).xx。