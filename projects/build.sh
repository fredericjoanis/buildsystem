#!/bin/bash

version=$(uname -m)

if [ "$OSTYPE" = "linux-gnu" ]; then
  if [ "$version" = "x86_64" ]; then
     ../tools/lua/lua64 --file=../build/build.lua $1 $2 $3 $4
  elif [ "$version" = "i686" ]; then
     ../tools/lua/lua32 --file=../build/build.lua $1 $2 $3 $4
  fi
elif [ "$OSTYPE" = "linux-gnueabihf" ]; then
  ../tools/lua/luaARM --file=../build/build.lua $1 $2 $3 $4
fi
