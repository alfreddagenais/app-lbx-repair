#!/bin/bash

if [ "$1" == "" ]; then
    echo "Zip file Path is empty"
    exit 128
fi

ZIP_FILE=$1

# Check zip file exist
if [ ! -f "$ZIP_FILE" ]; then
    echo "$ZIP_FILE does not exist."
    exit 1
fi

# Check file if is a lbx -> convert top zip
if [[ $ZIP_FILE =~ \.lbx$ ]];then
    ZIP_FILE_NEW="${ZIP_FILE/.lbx/.zip}"
    mv $ZIP_FILE $ZIP_FILE_NEW
    ZIP_FILE=$ZIP_FILE_NEW
fi

# Check file extension
if [[ ! $ZIP_FILE =~ \.zip$ ]];then
    echo "$ZIP_FILE is not an zip file."
    exit 1
fi

ZIP_REPAIR_FILE="$1.repair.zip"
LBX_FILE="${ZIP_FILE/.zip/.lbx}"

MINE=`file --mime-type "$ZIP_FILE"`
if [[ ( "$MINE" != *"application/zip"* ) && ( "$MINE" != *"application/octet-stream"* ) ]];then
    echo "$ZIP_FILE mime-type is not an zip type."
    exit 1
fi

# Check zip repair file exist
if test -f "$ZIP_REPAIR_FILE"; then
    unlink $ZIP_REPAIR_FILE
fi

# repair zip
echo "Y" | zip -FF $ZIP_FILE --out $ZIP_REPAIR_FILE

# Check zip repair file exist
if [ ! -f "$ZIP_REPAIR_FILE" ]; then
    echo "$ZIP_REPAIR_FILE does not exist."
    exit 1
fi

# Check lbx repair file exist
if [ -f "$LBX_FILE" ]; then
    unlink $LBX_FILE
fi

# Move Repair to lbx file
mv $ZIP_REPAIR_FILE $LBX_FILE

# Check zip repair file exist
if [ -f "$ZIP_REPAIR_FILE" ]; then
    unlink $ZIP_REPAIR_FILE
fi

# Check zip file exist
if [ -f "$ZIP_FILE" ]; then
    unlink $ZIP_FILE
fi

#bye bye
exit 0