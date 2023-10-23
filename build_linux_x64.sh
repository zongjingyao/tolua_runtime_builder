#!/bin/bash

# Only for lua 5.3

tolua="tolua_runtime"
luapath="lua53"
dynamiclibname="libtolua.so"
staticlibname="liblua.a"
outpath="Plugins/Linux/x86_64"

mkdir -p $outpath
cd $tolua
mkdir -p Linux/x86_64

cd $luapath
make clean
make linux BUILDMODE=static CC="gcc -fPIC -m64 -O2"
cp src/$staticlibname ../Linux/x86_64/$staticlibname
make clean
echo -e "\n[MAINTAINCE] build $staticlibname done\n"

cd ..
gcc -m64 -O2 -std=gnu99 -shared \
    tolua.c \
    int64.c \
    uint64.c \
    pb.c \
    lpeg/lpcap.c \
    lpeg/lpcode.c \
    lpeg/lpprint.c \
    lpeg/lptree.c \
    lpeg/lpvm.c \
    struct.c \
    cjson/strbuf.c \
    cjson/lua_cjson.c \
    cjson/fpconv.c \
    luasocket/auxiliar.c \
    luasocket/buffer.c \
    luasocket/except.c \
    luasocket/inet.c \
    luasocket/io.c \
    luasocket/luasocket.c \
    luasocket/mime.c \
    luasocket/options.c \
    luasocket/select.c \
    luasocket/tcp.c \
    luasocket/timeout.c \
    luasocket/udp.c \
    luasocket/usocket.c \
    luasocket/compat.c \
    -fPIC -o ../$outpath/$dynamiclibname \
    -I./ \
    -I$luapath/src \
    -Iluasocket \
    -Wl,--whole-archive Linux/x86_64/$staticlibname \
    -Wl,--no-whole-archive -static-libgcc -static-libstdc++

if [ "$?" = "0" ]; then
    echo -e "\n[MAINTAINCE] build $dynamiclibname success"
else
    echo -e "\n[MAINTAINCE] build $dynamiclibname failed"
fi
