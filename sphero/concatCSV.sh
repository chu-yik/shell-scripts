#!/bin/bash

# this shell script concats all .csv files in the directory
# taking only one header to avoid duplication


# TODO: another script to concat TXT (if needed)

# TODO: option to concat into specified file name

DIRECTORY="./"
OUTFILE_NAME="output.csv"
OUTFILE="$DIRECTORY$OUTFILE_NAME"

# print debug message
function debug {
    local TIME=`date +"%Y-%m-%d %H:%M:%S"`
    printf "[%s] %s\n" "$TIME" "$1"
}

# find number of csv files in given directory
# USAGE: numberOfCSVFiles "/path/to/directory"
function numberOfCSVFiles {
    echo `find "$1" -maxdepth 1 -type f -name "*.csv" | wc -l` # f: regular file
}

COUNT=$(numberOfCSVFiles "$DIRECTORY")
if [[ "$COUNT" -gt 0 ]]; then
    debug "Found $COUNT CSV Files."
    i=0                                             # File counter
    for CSV_FILE in "$DIRECTORY"*.csv; do
        if [[ "$CSV_FILE" != "$OUTFILE" ]]; then    # Avoid recursion
            if [[ $i -eq 0 ]]; then
                head -1 "$CSV_FILE" > "$OUTFILE"       # Copy header if it is the first file
            fi
            tail -n +2 "$CSV_FILE" >> "$OUTFILE"      # Append from 2nd line of each file
            echo -e "\n" >> "$OUTFILE"              # Append newline
            i=$(( $i + 1 ))                         # File counter increment
            debug "Done concating $CSV_FILE"
        fi
    done
    # remove newlines that are not needed
    sed -i '' /^[[:space:]]*$/d "$OUTFILE"
else
    debug "No CSV File Found in $DIRECTORY."
fi
