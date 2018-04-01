#!/bin/bash

# this shell script does the following:
# 1. unzips all .zip files recursively in the directory
# 2. added .txt to all renamed .txt files

ROOT_DIR="./"
CSV_DIR="all_csv"
TXT_DIR="all_txt"
ZIP_DIR="all_zip"


# print debug message
debug()
{
    local TIME=`date +"%Y-%m-%d %H:%M:%S"`
    printf "[%s] %s\n" "$TIME" "$1"
}

createRequiredFolders()
{
    createFolder "$1/$CSV_DIR"
    createFolder "$1/$TXT_DIR"
    createFolder "$1/$ZIP_DIR"
}

createFolder()
{
    if [[ -d "$1" ]]; then
        debug "$1 already exists"
    else
        debug "creating $1";
        mkdir "$1"
    fi
}

unzipAndMoveZipFiles()
{
    find "$1" -depth 1 -name "*.zip" | while read ZIP_FILE; do
        7z e "$ZIP_FILE" -o"$1" -aoa | grep "Extracting"
        mv "$ZIP_FILE" "$1/$ZIP_DIR"
    done
}

appendMissingCSVAndMoveCSVFiles()
{
    find "$1" -depth 1 -name "*.csv*" | while read CSV_FILE; do
        local TARGET=CSV_FILE
        if [[ ${CSV_FILE: -4} != ".csv" ]]; then
            mv "$CSV_FILE" "$CSV_FILE.csv"
            TARGET="$CSV_FILE.csv"
        fi
        mv "$TARGET" "$1/$CSV_DIR"
    done
}

appendMissingTXTAndMoveTXTFiles()
{
    find "$1" -depth 1 -name "*.txt*" | while read TXT_FILE; do
        local TARGET=TXT_FILE
        if [[ ${TXT_FILE: -4} != ".txt" ]]; then
            mv "$TXT_FILE" "$TXT_FILE.txt"
        fi
        mv "$TXT_FILE" "$1/$TXT_DIR"
    done
}

for DIRECTORY in "$ROOT_DIR"*/ ; do

    debug "working on $DIRECTORY"

    createRequiredFolders "$DIRECTORY"

    unzipAndMoveZipFiles "$DIRECTORY"

    appendMissingCSVAndMoveCSVFiles "$DIRECTORY"

    appendMissingTXTAndMoveTXTFiles "$DIRECTORY"

done