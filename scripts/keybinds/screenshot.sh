#!/bin/bash

OPTIONS=$(echo -e "-Crop\n-Fullscreen" | dmenu -p "Screenshot:")

case $OPTIONS in
	"-Crop") TOKEN="-s";;
	"-Fullscreen") TOKEN="-u";;
	*)
		dunstify "Invalid entry!"
		exit 1 
		;;
esac

SAVE=$(echo -e "-Clipboard\n-Save" | dmenu)

case $SAVE in
	"-Save")
		SAVEPATH=~/Pictures/Screenshots
		SAVENAME=$(date "+%Y%m%d-%H%M%S").png

		maim $TOKEN $SAVEPATH/$SAVENAME
		CHANGE=$(echo -e "No\nYes" | dmenu -p "Change image's name?")
		[ $CHANGE = "Yes" ] && NEW=$(echo -e "" | dmenu -p "New name:")

		if [ $NEW ]
		then
			COUNT=$(ls $SAVEPATH | grep $NEW | wc -l)
			[ $COUNT -gt 0 ] && NEW+=($COUNT).png || NEW+=.png
			mv $SAVEPATH/$SAVENAME $SAVEPATH/$NEW && SAVENAME=$NEW
		fi

		dunstify "$SAVENAME saved in $SAVEPATH"
		;;
	"-Clipboard")
		maim $TOKEN | xclip -selection clipboard -t image/png 
		dunstify "Screenshot saved in the clipboard!"
		;;
	*)
		dunstify "Invalid entry!"
		exit 1 
		;;
esac
