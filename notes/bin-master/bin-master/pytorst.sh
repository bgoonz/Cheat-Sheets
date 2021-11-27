#!/usr/bin/env bash
#
#	This script is designed to be used with makePydoc, update__date__ and pylint.
#	The reference page for this software is :
#	https://sites.google.com/site/naereencorp/liste-des-projets/makepydoc
#
#	__author__='Lilian BESSON'
#	__email__='lilian.bessonAROBASE@ATATnormaleDOTfr'
#	__version__='1.2'
#	__date__='jeu. 14/02/2013 at 05h:18m:10s '
#
# A simple script to automatize the generation of .rst file
#  from .py file, to include a module in a Sphinx documentation.
#
# Although I didn't find anything that already do this, I mad it.
#  For each file in $*, if it is a real .py file, it will create a .rst file,
#  unless the corresponding .rst file already exists, and in this case
#  it will simply print that the file already exists.

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
echo -e "*** ${blue} Starting to generate .rst files from .py (automatically).${white} ***"
echo -e "*** ${green} Script=$SCRIPT, Args=$ARGUMENTS.${white} ***\n\n"

# Explicitely said where the script was launched, and where it will really works:
if [ "$PWD_OLD" = "$PWD_REAL" ]
then
	echo -e "${green} The current folder [$PWD_OLD] is a real path.${white}"
else
	echo -e "${red}******************************************************************"
	echo -e "${red}* The current folder [$PWD_OLD] seems to not be the real path :"
	echo -e "${red}* The real path is [$PWD_REAL]. The script will work ${escp}4mIN THIS ABSOLUTE PATH.${escp}24m"
	echo -e "${red}******************************************************************${white}"
	cd "$PWD_REAL"
fi

# Argument testing
for arg in "$*"
do
	case "$arg" in
	-h*|-?|--h*|--?*)
		echo -e "${red}pytorst.sh [OPTIONS] modules${white}\n\n\
 A simple script to automatize the generation of .rst file\n\
  from .py file, to include a module in a Sphinx documentation.\n\
\n\
 Although I didn't find anything that already do this, I mad it.\n\
  For each file in \$*, if it is a real .py file, it will create a .rst file,\n\
  unless the corresponding .rst file already exists, and in this case\n\
  it will simply print that the file already exists.\n\
\n\
 ${red}It use pygmentize, so please install it before trying to use this script${white} (sudo apt-get install pygmentize).\n\
${blue}OPTIONS${white}:\n\
=========\n\
	${yellow}--help, -h, -?, --?${white}		Print this help,\n\
${blue}COPYRIGHTS${white}:\n\
===========\n\
	${red}Naereen Corp. (c) 12-01-2013${white}\n\
	 ${green}https://sites.google.com/site/naereencorp/\n\
	 mailto:naereen-corporation[@]laposte.net${white}"
		exit 0
		;;
	*)
		;;
	esac
done

underline(){
	# Create a string of '#' as long as the input string $1
#	echo -e "${green} Calling 'underline $*'${white}..."
	len=${#1}
	# Add ' Module'
	len=$((len + 7))
	output=""
	len_output=${#output}
	while [ $((len_output < len)) = "1" ]
	do
		output="${output}="
		len_output="${#output}"
#		echo -e "${green} Calling 'underline $*'${white}...$output $len_output"
#		echo -e "\t..."$((len_output < len))
	done
	# simply to underline correctly the name of the module in the .rst file.
	echo "$output"
}

py2rst(){
	module="${1%.py}"

	if [ "$module.py" = "$1" ] && [ -f "$module.py" ]
	then
		echo -e "${green} The file $1 ${blue}seems${white} to be a valid .py Python module file."
		if [ -f "$module.rst" ]
		then
			echo -e " The file $module.rst ${red}is already there${white} (and by default I don't want to delete it !)."
   		else
			echo -e " The name of ${blue}the module is $module${white}, and it is long of ${green}${#module} caracters${white}."
			echo -e "  So I'll have ${green}to underline it by ${#module} # ${white}"
#			echo -e "  (something like ${yellow}`underline $module`${white} if I'm correct)..."
			under=`underline "$module"`
			echo -e " The file $module.rst ${green}is not there${white} : I'm trying to create it (and it will be done ${green}cleverly${white})."
			echo -e "$module Module\n\
${under}\n\
\n\
.. automodule:: $module\n\
    :members:\n\
    :private-members:\n\
    :special-members:\n\
    :show-inheritance:\n\
\n\
..\n\
   This .rst file have been created using the Naereen CORP. script pytorst.sh,\n\
   for the module '$1', with the script '$SCRIPT' in the directory '`pwd`'.\n\
   Generated the `date`, by '$USER' on '$HOSTNAME'.\n\
   Feel free to contact us : Naereen Corp. (c) 12-01-2013\n\
   https://sites.google.com/site/naereencorp/\n\
   mailto:naereen-corporation(@}laposte.net\n" > "$module.rst"
  			echo -e " ....... ok\n${blue} This is the content of the new file $module.rst, generated to autodoc the module $module (file $module.py) with Sphinx.${white}\n>"
  			pygmentize -f terminal256 -g "$module.rst"
  			echo -e "<"
  			if [ -f "index.rst" ]
  			then
	  			res_grep=`grep "$module" index.rst &> /dev/null`
	  			if [ "$?" = "0" ]
	  			then
		  			echo -e ":)\t${green} The module $module seems to be weel include in your index.rst : good job !${white}."
		  		else
		  			echo -e "***\t${red} Don't forget to include it in your index.rst file !${white}."
		  		fi
	  		else
	  			echo -e "\n\t${red} ** WARNING ** : the main file index.rst is *NOT* present in this directory ! ${white}."
	  		fi
   		fi
	else
		echo -e "${red} The file $1 is not a valid .py Python module file !${white} I don't know how to handle it, so I pass."
	fi
}

# New, .rst.pytorst are all saved or/and remplace, like index.rst.pytorst WAS.
for i in *.rst.pytorst
do
	i=${i%.rst.pytorst}
	echo -e "\t Examining the file RST $i (i.e.: *$i.rst.pytorst* and *$i.rst*)"
	if [ -f "$i.rst.pytorst" ] && [ ! -f "$i.rst" ]
	then
		echo -e "\t\t ${blue}$i.rst.pytorst : found. Copying to $i.rst !${white}\n"
		cp "$i.rst.pytorst" "$i.rst"
	else
		if [ -f "$i.rst" ]
		then
			echo -e "\t\t ${blue}$i.rst : found. Saving to $i.rst.pytorst~ !${white}\n"
			cp "$i.rst" "$i.rst.pytorst~"
			cp "$i.rst.pytorst" "$i.rst"
		else
			echo -e "\t\t ${red}Nor $i.rst.pytorst or $i.rst is present.\n**** WARNING : Sphinx will complain about it ! ****${white}\n"
		fi
	fi
done

for i in $ARGUMENTS
do
	py2rst "$i"
	echo -e "\t\t ${blue}Next !${white}\n"
done


echo -e "\n\t*** ${green} Done.${white} ***"
