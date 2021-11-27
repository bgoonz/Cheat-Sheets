#!/usr/bin/env bash
# __author__='Lilian BESSON'
# __email__='lilian.bessonATnormaleDOTfr'
# __version__='0.2
# __date__ = '21-01-2014'
#
# A simple script to automatize the conversion of SVG images
# to .png (for web) and to .pdf (for latexpdf)

SCRIPT="$0"
ARGUMENTS="$*"

# Avoid symlinks
PWD_OLD=`pwd`
PWD_REAL=`pwd -P`

# Colors
escp="\033["
blue="${escp}01;34m"
red="${escp}01;31m"
green="${escp}01;32m"
yellow="${escp}01;35m"
white="${escp}01;37m"

# Start
echo -e "${blue} Starting to convert images from .svg (automatically).${white}"
echo -e "${green} Script=$SCRIPT, Args=$ARGUMENTS.${white}\n"

# Explicitely said where the script was launched, and where it will really works:
if [ "$PWD_OLD" = "$PWD_REAL" ]
then
	echo -e "${green} The current folder [$PWD_OLD] is a real path.${white}\n\n"
else
	echo -e "${red}The current folder [$PWD_OLD] seems to not be the real path :"
	echo -e "${red}The real path is [$PWD_REAL]. The script will work ${escp}4mIN THIS ABSOLUTE PATH.${escp}24m"
	cd "$PWD_REAL"
fi

# Argument testing
for arg in "$@"; do
	case "$arg" in
	-h*|-?|--h*|--?*)
		echo -e "${red}svg2others.sh [OPTIONS] image1.svg [images.svg]${white}\n\n\
  A simple script to automatize the conversion of SVG images\n\
 to .png (for web) and to .pdf (for latexpdf)\n\
\n\
 ${red}It uses rsvg-convert, so please install it before trying to use this script${white}\n\
 (sudo apt-get install librsvg2-bin).\n\
${blue}OPTIONS${white}:\n\
=========\n\
	${yellow}--help, -h, -?, --?${white}		Print this help,\n\
${blue}COPYRIGHTS${white}:\n\
===========\n\
	${red}Lilian BESSON (C) 23-04-2013${white}\n\
	${green}http://perso.crans.org/besson/bin/svg2others.sh${white}"
		exit 0
		;;
	*)
		;;
	esac
done

svg2others(){
	source="${1%.svg}"
	if [ "$source.svg" = "$1" ] && [ -f "$source.svg" ]
	then
		echo -e "${green} The file $1 ${blue}seems${white} to be a valid .svg image file."

		if [ ! -f "$source.pdf" ]; then
		 rsvg-convert -f pdf -o "$source.pdf" "$source.svg" && \
		 echo -e "${green}   $source.pdf ${blue}created${white}...."
		else
		 echo -e "${red} the $source.pdf output is already there..."
		fi

		if [ ! -f "$source.png" ]; then
		 rsvg-convert -f png "$source.svg" "$source.png" && \
		 echo -e "${green}   $source.png ${blue}created${white}...."
		else
		 echo -e "${red} the $source.png output is already there..."
		fi
	else
		echo -e "${red} The file $1 is not a valid .svg image file !${white} I don't know how to handle it, so I pass."
	fi
}

for i in $ARGUMENTS
do
	svg2others "$i"
	echo -e "${blue}Next !${white}"
done

echo -e "${green} Done.${white}"