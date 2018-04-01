# check if hidden files are visible and store result
isVisible=$(defaults read com.apple.finder AppleShowAllFiles)
# echo $isVisible

# toggle the opposite 
if test $isVisible -eq 0
then
	echo "Showing Hidden Files"
	defaults write com.apple.finder AppleShowAllFiles 1
else
	echo "Hiding Hidden Files"
	defaults write com.apple.finder AppleShowAllFiles 0
fi

# force change
killall Finder
