# change this to 1 if we want to keep zip files - probably not because of space limitation
KEEP_ZIP=1
# whether this script shall be run in debug mode
DEBUG=0

# folders
CWD=""
TOROOT="/Users/MC/Desktop/20160921_Audio 29 units retest/LOG DIGGING/"

# === FUNCTIONS ===

# print newline
function newline {
    printf "\n"
}

# print separator
function separator {
    printf "%s\n" "$SEP"
}

# print debug message
function debug {
    local TIME=`date +"%Y-%m-%d %H:%M:%S"`
    printf "[%s] %s\n" "$TIME" "$1"
}

# === UTIL ===

# find number of zip files in given directory
# USAGE: numberOfZipFiles "/path/to/directory"
function numberOfZipFiles {
    echo `find "$1" -maxdepth 1 -type f -name "*.zip" | wc -l` # f: regular file
}

function debugPrint {
    if [[ "$DEBUG" -gt 0 ]]; then
        debug "$1"
    fi
}

function init {
    debug "script started."
    # check if "debug" flag is passed
    if [[ $# -gt 0 ]] && [[ $1 == "debug" ]]; then
        DEBUG=1
        printf "\n=== debug mode is manually turned on ===\n"
    fi
}

function createFolder {
    if [[ -d "$1" ]]; then
        debugPrint "$1 exists."
    else
        debugPrint "creating $1."
        mkdir "$1"
    fi
}

# three folders are needed in one working directory
# 1. processing/ 2. processed/ 3. bak/
function createRequiredFolders {
    createFolder "$CWD/txt"
    createFolder "$CWD/csv"
    createFolder "$CWD/bak"
}

function moveFileToBakFolder {
    local BASENAME=`basename "$1"`
    mv "$1" "$CWD/bak/$BASENAME"
}

# --- ZIP MANIPULATION ---

function unzipAllCSVFileToProcessingFolder {
    local FOLDER="$CWD"
    newline
    debugPrint "unzipping CSV/TXT files from zip files in $CWD"

    local COUNT=$(numberOfZipFiles "$CWD")

    if [[ "$COUNT" -gt 0 ]]; then
        for ZIP_FILE in "$CWD"*.zip ; do
            debugPrint "unzipping $ZIP_FILE"
            # NOTE1: UNZIP cannot handle Chinese character
            # unzip -oq "$ZIP_FILE" '*.csv' -d "$FOLDER" # o: overwrite, q: quiet
            # NOTE2: TAR cannot handle zip in Ubuntu
            # tar -xf "$ZIP_FILE" --include "*.csv" -C "$FOLDER"
            # using 7z
            7z e "$ZIP_FILE" -r -i\!\*.csv -o"$FOLDER/csv/" -aou | grep "Extracting"
            7z e "$ZIP_FILE" -r -i\!\*.txt -o"$FOLDER/txt/" -aou | grep "Extracting"
            # aou: auto rename extracting file

            # move the zip file to /bak or discard depending on the flag
            if [[ "$KEEP_ZIP" == 1 ]]; then
                moveFileToBakFolder "$ZIP_FILE"
            else
                rm "$ZIP_FILE"
            fi
        done
    else
        debugPrint "no zip file found."
    fi
}

# === MAIN ===
init $@
# actual processing
for DIRECTORY in "$TOROOT"*/ ; do
    debugPrint "--- working on $DIRECTORY ---"
    CWD="$DIRECTORY"
    createRequiredFolders
    unzipAllCSVFileToProcessingFolder
done