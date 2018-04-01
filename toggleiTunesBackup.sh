# check if device backup is disabled
isDisable=$(defaults read com.apple.iTunes DeviceBackupsDisabled)

# toggle the opposite
if test $isDisable -eq 0 # if false then set true and vice versa
then
	echo "Disabling iTunes Backup"
    defaults write com.apple.iTunes DeviceBackupsDisabled -bool true
else
	echo "Enabling iTunes Backup"
	defaults write com.apple.iTunes DeviceBackupsDisabled -bool false
fi
