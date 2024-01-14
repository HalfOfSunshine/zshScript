DIR=$(pwd);

if [[ -d $DIR/ZJAdSDK ]]
then
cd ../
DIR=$(pwd)
fi

if [[ -d $DIR/ZJSDK/ZJAdSDK ]]
then
echo "当前处理文件夹:$DIR";
else
echo "当前文件夹路径有误，请检查路径:$(pwd)";
exit 0;
fi

ORGDIR=/Users/mamingkang/ZJSDK_workPace/iOS_ZjSDK_Pro_Optimize;
DEPENDENCY_DIR=/Users/mamingkang/ZJSDK_workPace/iOS_ZjSDK_Pro_Optimize/ZJSDKDemo/ZJSDKDemo/lib/SubModuleDependencys;
if [[ ! -d $ORGDIR ]]
then
    echo "请输入SDK文件夹，以提供需要复制的第三方依赖库";
    exit 0;
fi
echo "sdk源文件夹:$ORGDIR";

rm -rf $DIR/.git
rm -rf $DIR/.gitignore
rm -rf $DIR/.travis.yml
rm -rf $DIR/cp_from_path.sh
rm -rf $DIR/LICENSE
rm -rf $DIR/README.md
rm -rf $DIR/ZJSDKDemo/Pods
rm -rf $DIR/ZJSDKDemo/Podfile.lock

find $DIR/ZJSDK/ZJSDKModuleBD/*|grep -v "libZJSDKModule" | xargs rm -rf
if [ $? -eq 0 ]; then
    echo "文件已成功删除"
else
    echo "文件删除失败"
fi
find $DIR/ZJSDK/ZJSDKModuleBeiZi/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModuleCSJ/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModuleGDT/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModuleGoogle/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModulePangle/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModuleDSP/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModuleKS/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModuleMTG/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModuleSIG/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModuleWM/*|grep -v "libZJSDKModule" | xargs rm -rf
find $DIR/ZJSDK/ZJSDKModuleYM/*|grep -v "libZJSDKModule" | xargs rm -rf
cp -r -P $DEPENDENCY_DIR/Baidu      $DIR/ZJSDK/ZJSDKModuleBD
cp -r -P $DEPENDENCY_DIR/BeiZi      $DIR/ZJSDK/ZJSDKModuleBeiZi
cp -r -P $DEPENDENCY_DIR/CSJ        $DIR/ZJSDK/ZJSDKModuleCSJ
cp -r -P $DEPENDENCY_DIR/GDT        $DIR/ZJSDK/ZJSDKModuleGDT
cp -r -P $DEPENDENCY_DIR/Google     $DIR/ZJSDK/ZJSDKModuleGoogle
cp -r -P $DEPENDENCY_DIR/Pangle     $DIR/ZJSDK/ZJSDKModulePangle
cp -r -P $DEPENDENCY_DIR/KS         $DIR/ZJSDK/ZJSDKModuleKS
cp -r -P $DEPENDENCY_DIR/MTG        $DIR/ZJSDK/ZJSDKModuleMTG
cp -r -P $DEPENDENCY_DIR/SIG        $DIR/ZJSDK/ZJSDKModuleSIG
cp -r -P $DEPENDENCY_DIR/WM         $DIR/ZJSDK/ZJSDKModuleWM
cp -r -P $DEPENDENCY_DIR/DSP        $DIR/ZJSDK/ZJSDKModuleDSP

cd ..
curl -OL http://static.jrongjie.com/android_sdk/sdk.config.json