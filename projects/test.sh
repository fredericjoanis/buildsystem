#!/bin/bash

if [ "$OSTYPE" = "linux-gnu" ]; then
  ../tools/lua/lua64 --file=../build/test.lua $1 $2 $3 $4
elif [ "$OSTYPE" = "linux-gnueabihf" ]; then
  ../tools/lua/luaARM --file=../build/test.lua $1 $2 $3 $4
fi
