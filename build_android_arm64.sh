#!/bin/bash

# Only for lua 5.3

tolua="tolua_runtime"
luapath="lua53"
dynamiclibname="libtolua.so"
staticlibname="liblua.a"
outpath="Plugins/Android/arm64-v8a"

NDKABI=21

mkdir -p $outpath

cd $tolua/$luapath/src

lualinkpath="../../android53"
ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI
ndk-build APP_ABI="arm64-v8a" APP_PLATFORM=android-$NDKABI
cp obj/local/arm64-v8a/$staticlibname $lualinkpath/jni/
ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI

cd $lualinkpath
ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI
ndk-build APP_ABI="arm64-v8a" APP_PLATFORM=android-$NDKABI
cp libs/arm64-v8a/$dynamiclibname ../../$outpath
ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-$NDKABI
