# Nandi: 2013-11-06
# Check provisioning profile script


function usage()
{
    echo "Usage: provisioning_check [file path] [Provisioning To Check]"
    echo " ( TO check the provisioning profile exists in the ipa) "
    echo ""
    exit
}


if [ "$1" = "" ] || [ "$2" = "" ]; then
    usage
fi

DIR_NAME="DIR_$2"
# use provisioning profile name to create a folder
mkdir $DIR_NAME

# unzip the ipa
unzip -qq -o $1 -d $DIR_NAME

# get the app name
APP_NAME=`ls "$DIR_NAME/Payload/"`

DIR_PATH="$DIR_NAME/Payload/$APP_NAME"

PROV_FILE="$DIR_PATH/embedded.mobileprovision"


#find the provision
result=`awk '$0 ~ str{print NR-1 FS b}{b=$0}' str="$2" $PROV_FILE`

#get the result's length
StringLen=$(echo ${#result})

if [ $StringLen -lt 1 ]; then
    echo ""
    echo "Provisioning profile [$2] not found."
    echo ""
else
    echo ""
    echo "Provisioning profile [$2] exists."
    echo $result
    echo ""
fi

rm -rf $DIR_NAME
