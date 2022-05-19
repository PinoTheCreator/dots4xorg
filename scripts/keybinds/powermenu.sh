#!/bin/bash

OPTIONS=$(echo -e "-Poweroff\n-Reboot" | dmenu)

case $OPTIONS in
	"-Poweroff") SUDO_ASKPASS=~/scripts/dpass.sh sudo -A poweroff;;
	"-Reboot") SUDO_ASKPASS=~/scripts/dpass.sh sudo -A reboot;;
	*) dunstify "Invalid entry!" && exit 1;;
esac
