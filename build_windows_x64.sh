# Only for lua 5.3

tolua="tolua_runtime"
luapath="lua53"
dynamiclibname="tolua.dll"
staticlibname="liblua.a"
outpath="Plugins/Windows/x86_64"

mkdir -p $outpath

cd $tolua/$luapath
make clean
make mingw BUILDMODE=static CC="gcc -m64 -std=gnu99"
cp src/$staticlibname ../window/x86_64/$staticlibname
make clean

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
    luasocket/wsocket.c \
    luasocket/compat.c \
    -o ../$outpath/$dynamiclibname \
    -I./ \
    -I$luapath/src \
    -Icjson \
    -Iluasocket \
    -Ilpeg \
    -lws2_32 \
    -Wl,--whole-archive window/x86_64/$staticlibname -Wl,--no-whole-archive -static-libgcc -static-libstdc++

echo "build $dynamiclibname success"
