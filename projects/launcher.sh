#!/bin/bash

IFS='_ ' read -a arr <<< $1

solution=${arr[0]}
ide=${arr[1]}
os=${arr[2]}
version=$(uname -m)

if [ "$OSTYPE" = "linux-gnu" ]; then
  if [ "$version" = "x86_64" ]; then
     ../tools/premake/premake64 --file=../build/$solution/$os.lua $ide
  elif [ "$version" = "i686" ]; then
     ../tools/premake/premake32 --file=../build/$solution/$os.lua $ide
  fi
elif [ "$OSTYPE" = "linux-gnueabihf" ]; then
  ../tools/premake/premakeARM --file=../build/$solution/$os.lua $ide
fi

if [ "$?" != "0" ]; then
   read -p "An error occured. Press enter to close."
   exit 1
fi

if [ "$2" = "noide" ]; then
  exit 0
fi

#If an ide exist someday, use that one here.
exit 0
