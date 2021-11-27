#!/usr/bin/env bash
# Author:		Michael Bianco, http://developer.mabwebdesign.com/, <software@mabwebdesign.com>
# Description:	This script will uncompress CSS files compressed with CSS Optimizer (http://developer.mabwebdesign.com/cssoptimizer)
#				This script requires the GNU version of the sed command, change the SED_COMMAND variable to represent the path to your GNU sed
#				You can download GNU sed via fink if you dont have it, or compile it from source at: http://directory.fsf.org/GNU/sed.html
# Usage:		unCompress.bash input.css output.css
#				uncompressed with go to stdout if output.css is not given

SED_COMMAND=/bin/sed  # path to GNU sed

if [ ! -e "$1" ]; then
	echo "Enter a valid input file."
	exit 1
fi

if [ -z "$2" ] && [ -e "$2" ]; then
	echo "File:'$2' already exists. Clear file for output? (y/n)"
	read
	if [ $REPLY == "n" ]; then
		echo "Please try running the script with another output file."
		exit 2
	else
		exec 1>"$2"
	fi
elif [ ! -z "$2" ]; then
	exec 1>"$2"
fi

cat "$1" |
"$SED_COMMAND" 's/\([;{]\)\([^\n]\)/\1\n\t\2/g' | 	# do main formatting for all CSS properties and the beggining of CSS declerations
"$SED_COMMAND" 's/\([^}]\)}/\1;\n}\n\n/g' | 		# end of decleration formatting
"$SED_COMMAND" 's/{/ {/g' |							# more beggining of CSS decleration
"$SED_COMMAND" 's/[,]/& /g' | 						# add some spaces for readability
"$SED_COMMAND" '
/}/ {
	N
	N
	s/}\n\([^\n]\)/}\n\n\1/
}'													# make sure there are two \n's after the closing brace
exit 0
