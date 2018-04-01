#!/bin/bash
#
# Created by MC michael.chu@sphero.com | 2016-08-24
#
# This script recursively finds the occurence of a given string
# in all files contained in given directory and its sub-directories.
#
# It will output the path to the file if the target string is found in that file.
#
# USAGE:
# ./recursiveFind.sh targetString [-v] [-p targetDirectory] [-t fileType]
#
# EXAMPLE:
# ./recursiveFind.sh d328347b9875 -v -p ./logs/fb14/ -t txt
#
# required arguement:
# targetString: target string to be searched, case sensitive
#
# optional arguments:
# -p (or --path) targetDirectory: target directory to be searched, default is the current directory (./)
# -t (or --type) fileType: file extension to be searched, default is all files
# -v (or --verbose) verbose: if this argument is supplied more debug messages will be printed
#

VERBOSE=0
TARGET=""
DIRECTORY="./"
TYPE=""

# print debug message
debug() {
    if [[ "$VERBOSE" == 1 ]]; then
        local TIME=`date +"%Y-%m-%d %H:%M:%S"`
        printf "[%s] %s\n" "$TIME" "$1"
    fi
}

printMessage() {
    local TIME=`date +"%Y-%m-%d %H:%M:%S"`
    printf "[%s] %s\n" "$TIME" "$1"
}

# print newline
newline() {
    printf "\n"
}

# $1: target string
# $2: target directory
# $3: target file type
# $4: source file, if any
findTargetStringInDirectoryWithFileType () {
    debug "Finding [$1] in [$2] | [type: $3] | [source: $4]"
    find "$2" -name "*$3" | while read FILE; do
        local BASE_FILE=`basename "$FILE"`
        local BASE_SOURCE=`basename "$4"`
        # skipping directory itself, grep only files, also skip source file
        if [[ -f "$FILE" ]] && [[ "$BASE_FILE" != "$BASE_SOURCE" ]]; then

            if grep -q "$1" "$FILE"; then
                printMessage "FOUND [$1] in [$FILE]"
            fi
        fi
    done
}

# exit early if no targetString is given
if [[ $# < 1 ]]; then
    printMessage "ERROR: please provide target string!"
    exit
fi
# save targetString
TARGET="$1"
shift
# parsing other arguments
while [[ $# > 0 ]]; do
    key="$1"
    case $key in
    -v|--verbose)
        VERBOSE=1
    ;;
    -p|--path)
        DIRECTORY="$2"
        shift # past argument
    ;;
    -t|--type)
        TYPE="$2"
        shift # past argument
    ;;
    *)
        printMessage "Unknown Option $1"
    ;;
    esac
shift
done

# If target is a file
if [[ -f "$TARGET" ]]; then
    printMessage "[$TARGET] is a file, performing readline and search ..."
    while IFS='' read -r line || [[ -n "$line" ]]; do
        findTargetStringInDirectoryWithFileType "$line" "$DIRECTORY" "$TYPE" "$TARGET"
    done < "$TARGET"
else
    findTargetStringInDirectoryWithFileType "$TARGET" "$DIRECTORY" "$TYPE"
fi
debug "DONE"
# END
