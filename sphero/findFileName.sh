#!/bin/bash
#
# Created by MC michael.chu@sphero.com | 2016-08-31
#
# This script recursively finds the occurence of a given string in file name
# in all files contained in given directory and its sub-directories.
#
# It will output the path to the file if the target string is found in that file.
#
# USAGE:
# ./recursiveFind.sh name [-p targetDirectory]
#
# EXAMPLE:
# ./recursiveFind.sh Station40 -p ./logData
#
# required arguement:
# targetString: target string to be searched, case sensitive
#
# optional arguements:
# -p (or --path) targetDirectory: target directory to be searched, default is the current directory (./)
#

TARGET=""
DIRECTORY="./"
TYPE=""

# print debug message
debug() {
    local TIME=`date +"%Y-%m-%d %H:%M:%S"`
    printf "[%s] %s\n" "$TIME" "$1"
}

# print newline
newline() {
    printf "\n"
}

# exit early if no targetString is given
if [[ $# < 1 ]]; then
    debug "ERROR: please provide target string!"
    exit
fi
# save targetString
TARGET="$1"
shift
# parsing other arguments
while [[ $# > 1 ]]; do
key="$1"
case $key in
    -p|--path)
    DIRECTORY="$2"
    shift # past argument
    ;;
    *)
    debug "Unknown Option $1"
    ;;
esac
shift
done
# START
debug "Finding files with [$TARGET] in file name."
newline
find "$DIRECTORY" -name "*$TARGET*" -tpye f
# END
