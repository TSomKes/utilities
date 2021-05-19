#!/bin/bash
#
# Create ~/.local/bin symlinks to utilities
# NB:  Copied from dotfiles file

BIN_DIR=~/.local/bin

# Find the absolute path of this script
# "Temporarily" cd to this script's location & pwd it into the variable
UTILITIES_ABS_PATH=$(cd `dirname $0` && pwd)

# Look for options listed in given string
# ("fi" means we'll accept -f or -i, etc.)
while getopts ":fhi" opt; do
	case $opt in
		# -f == Force the 
		f)
			FLAG="--force"
		;;
		h)
			echo "  -f 		forces replacement of existing files"
			echo "  -i 		prompt whether to replace existing files"
			echo "  -h 		give this help list"
			exit 1
		;;
		i)
			FLAG="--interactive"
		;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			echo "Try -h for more information." >&2
			exit 1
		;;
	esac
done

ln $FLAG -s $UTILITIES_ABS_PATH/markdownz.sh $BIN_DIR/markdownz
ln $FLAG -s $UTILITIES_ABS_PATH/noisez.sh $BIN_DIR/noisez
ln $FLAG -s $UTILITIES_ABS_PATH/scrotz.sh $BIN_DIR/scrotz
ln $FLAG -s $UTILITIES_ABS_PATH/start-minecraft.sh $BIN_DIR/start-minecraft
ln $FLAG -s $UTILITIES_ABS_PATH/tz.sh $BIN_DIR/tz
