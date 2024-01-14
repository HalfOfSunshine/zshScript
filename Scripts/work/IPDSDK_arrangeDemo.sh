DIR=$(pwd);

if [ -d $DIR/IPDAdSDK ]
then
cd ../
DIR=$(pwd)
fi

if [ -d $DIR/IPDSDK/IPDAdSDK ]
then
echo "当前处理文件夹:$DIR";
else
echo "当前文件夹路径有误，请检查路径:$(pwd)";
exit 0;
fi

ORGDIR="/Users/mamingkang/ZJSDK_workPace/IPDSDK-iOS";
DEPENDENCY_DIR="/Users/mamingkang/ZJSDK_workPace/IPDSDK-iOS/IPDSDKDemo/IPDSDKDemo/lib/SubModuleDependencys"
if [[ ! -d $ORGDIR ]]
then
    echo "请输入SDK文件夹，以提供需要复制的第三方依赖库";
    exit 1;
fi
echo "sdk源文件夹:$ORGDIR";

rm -rf $DIR/.git
rm -rf $DIR/.gitignore
rm -rf $DIR/.travis.yml
rm -rf $DIR/cp_from_path.sh
rm -rf $DIR/LICENSE
rm -rf $DIR/README.md
rm -rf $DIR/Example/Pods
rm -rf $DIR/Example/Podfile.lock

find $DIR/DSPSDK/DSPSDKModuleBD/*|grep -v "libDSPSDKModule" | xargs rm -rf
if [ $? -eq 0 ]; then
    echo "文件已成功删除"
else
    echo "文件删除失败"
fi
find $DIR/IPDSDK/IPDSDKModuleBD/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModuleBeiZi/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModuleCSJ/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModuleGDT/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModuleGoogle/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModulePangle/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModuleKS/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModuleMTG/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModuleSIG/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModuleWM/*|grep -v "libIPDSDKModule" | xargs rm -rf
find $DIR/IPDSDK/IPDSDKModuleDSP/*|grep -v "libIPDSDKModule" | xargs rm -rf
cp -r -P $DEPENDENCY_DIR/Baidu      $DIR/IPDSDK/IPDSDKModuleBD
cp -r -P $DEPENDENCY_DIR/BeiZi      $DIR/IPDSDK/IPDSDKModuleBeiZi
cp -r -P $DEPENDENCY_DIR/CSJ        $DIR/IPDSDK/IPDSDKModuleCSJ
cp -r -P $DEPENDENCY_DIR/GDT        $DIR/IPDSDK/IPDSDKModuleGDT
cp -r -P $DEPENDENCY_DIR/Google     $DIR/IPDSDK/IPDSDKModuleGoogle
cp -r -P $DEPENDENCY_DIR/Pangle     $DIR/IPDSDK/IPDSDKModulePangle
cp -r -P $DEPENDENCY_DIR/KS         $DIR/IPDSDK/IPDSDKModuleKS
cp -r -P $DEPENDENCY_DIR/MTG        $DIR/IPDSDK/IPDSDKModuleMTG
cp -r -P $DEPENDENCY_DIR/SIG        $DIR/IPDSDK/IPDSDKModuleSIG
cp -r -P $DEPENDENCY_DIR/WM         $DIR/IPDSDK/IPDSDKModuleWM
cp -r -P $DEPENDENCY_DIR/DSP        $DIR/IPDSDK/IPDSDKModuleDSP

cd ..
curl -OL https://static.hzshuyu.cn/app_ipd/sdk.config.json