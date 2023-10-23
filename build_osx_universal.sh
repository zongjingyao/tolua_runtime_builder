#!/usr/bin/env bash

# Only for lua 5.3

tolua="tolua_runtime"
luapath="macnojit53"
outpath="Plugins/OSX"

mkdir -p $outpath
cd $tolua/$luapath
xcodebuild clean
xcodebuild -configuration=Release
cp -r build/Release/tolua.bundle ../../$outpath
