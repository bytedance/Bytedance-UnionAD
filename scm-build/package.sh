#! /bin/bash
#
# 打包编译完成的 Framework ，导出最终的 发版zip
cd ../

FRAMEWORK_Bundle="./Bytedance-UnionAd/Frameworks/BUAdSDK.bundle"
FRAMEWORK_PATH="./Bytedance-UnionAd/Frameworks/BUAdSDK.framework"
FRAMEWORK_Document="./Bytedance-UnionAd/Document/UnioniOSSDK.md"
FRAMEWORK_Demo="./Example/BUAdSDKDemo"
FRAMEWORK_TARGET="./Example/BUAdSDKDemo/BUAdSDKDemo/Frameworks"

function buildSDKs() {
    echo "begin build sdks"
}

function buildDemo () {
    echo "begin package demo"
}

function buildDocument () {
    echo "begin package document"
}

function check () {
#   更新总失败，先删除旧文件再加入新文件
    if [ -d ${FRAMEWORK_TARGET}/BUAdSDK.bundle ]; then
        rm -Rf ${FRAMEWORK_TARGET}/BUAdSDK.bundle
    fi

    if [ -d ${FRAMEWORK_TARGET}/BUAdSDK.framework ]; then
        rm -Rf ${FRAMEWORK_TARGET}/BUAdSDK.framework
    fi


    cp -R ${FRAMEWORK_PATH} ${FRAMEWORK_TARGET}
    cp -R ${FRAMEWORK_Bundle} ${FRAMEWORK_TARGET}

}

function pack () {
    if [ -d union_platform_iOS ]; then
        rm -Rf union_platform_iOS
    fi

    mkdir union_platform_iOS

#    复制frameWork
    cp -R ${FRAMEWORK_PATH} union_platform_iOS
#    复制bundle
    cp -R ${FRAMEWORK_Bundle} union_platform_iOS
#    复制文档
    cp -R ${FRAMEWORK_Document} union_platform_iOS
#    复制对外demo
    cp -R ${FRAMEWORK_Demo} union_platform_iOS
}


function main () {
    buildSDKs
    buildDemo
    buildDocument
    check
    pack
    exit 0
}

main
