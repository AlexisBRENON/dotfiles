#! /bin/sh

# Add luarocks lib to luapath
export LUA_PATH=${HOME}'/.luarocks/share/lua/5.3/?.lua;'${HOME}'/.luarocks/share/lua/5.3/?/init.lua;/usr/share/lua/5.3/?.lua;/usr/share/lua/5.3/?/init.lua;/usr/lib/lua/5.3/?.lua;/usr/lib/lua/5.3/?/init.lua;./?.lua;./?/init.lua'
export LUA_CPATH=${HOME}'/.luarocks/lib/lua/5.3/?.so;/usr/lib/lua/5.3/?.so;/usr/lib/lua/5.3/loadall.so;./?.so'


TRAVIS_HOME="${HOME}/.travis"

export GOPATH="${HOME}/Documents/Development/projects/go"
