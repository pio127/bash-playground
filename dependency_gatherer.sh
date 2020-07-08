#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [ !$(command -v patchelf 1>/dev/null 2>&1) ]; then
   echo -e "${RED}ERROR${NC}: patchelf command not found" 
   exit 1 
fi

if [ $# -ne 1 ]; then
    echo -e "${RED}ERROR${NC}: Binary file path needed as an argument." 
    exit 1
fi

FILENAME=`basename $1 | cut -d"." -f 1` 
DIRECTORY="${FILENAME}_gathered_dependencies"

FILES_LIST=`ldd -v $1 | \
            awk '{if($3 == "=>") print $4; else print $3}' | \
            sort | uniq | tee preview_files.txt |\
            tr '\n\r' ' '`

mkdir -p $DIRECTORY && cp -v $FILES_LIST -t $DIRECTORY

for file in `ls $DIRECTORY`; do 
    patchelf --set-rpath "./" `realpath "$DIRECTORY/$file"`
done

echo -e "${GREEN}All needed dependencies gathered to a folder: $DIRECTORY${NC}"
