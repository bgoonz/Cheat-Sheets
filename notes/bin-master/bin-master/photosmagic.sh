#! /usr/bin/env /bin/bash
# By: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 16-04-2016
#
# photosmagic.sh, a small tool to optimize and clean every jpg, JPG, jpeg, JPEG, png, PNG photos of a directory.
#
# Warning: Can run for hours if the number of photos is too big!
# Warning: should not be ran twice on the same photos (optimizing an optimize photo reduces significantly the quality!).
#
# Online: https://bitbucket.org/lbesson/bin/src/master/photosmagic.sh
#
# Licence: [GPLv3](http://perso.crans.org/besson/LICENCE.html)
version='0.5'

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
# set -euo pipefail

. ~/.color.sh
# Add here options
NOANSI='false'
JUSTVERSION='false'
for i in "$@"; do
    case "$i" in
        --noansi )
            NOANSI='true'
            . ~/.nocolor.sh
            shift
            ;;
        --version | -v )
            JUSTVERSION='true'
            shift
            ;;
        --help | -h | -? )
			echo -e "Usage: ${green}$0${white} [--help]"
			echo -e "  Run without option to clean-up and compress JPEG/PNG photos in the current directory."
			exit 0
		    ;;
    esac
done

# Copyrights and options
echo -e "${green}$0${white} v${version} : copyright (C) 2016 Lilian Besson"
echo -e "You can find it online (https://bitbucket.org/lbesson/bin/src/master/photosmagic.sh)"
echo -e "This is free software, and you are welcome to redistribute it under certain conditions."
echo -e "This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
[ "X${JUSTVERSION}" = "Xtrue" ] && exit 1

# Script

log=/tmp/"$(basename $0)".log
logjpeg=/tmp/"$(basename $0)"_jpeg.log
logpng=/tmp/"$(basename $0)"_png.log

clear
echo -e "${yellow}Photos magic : in $(pwd) ($(date))${white}" | tee $log
echo -e "${cyan}Currently weighting:${white} $(du -kh)" | tee -a $log
du -kh > du.log~

echo -e "${red}Working with :${black}" | tee -a $log
find ./ -type f -iname '*'.jpeg -o -iname '*'.jpg -o -iname '*'.png | tee -a $log

echo -e "${white}Sure ?"

# FIXME do an option here
#simulate_jpeg="--noaction"
#simulate_png="-simulate"

time (
	echo -e "${red}Smoothing names...${white}" | tee -a $log
	# read  # DEBUG
	Smooth_Name.sh --batch
	notify-send --icon=jpg "$(basename $0)" "I am done <b>smoothing the name</b> (in $(pwd))."
	echo -e "${red}Compressing all JPEG (*.jpe?g, *.JPE?G) pictures...${white} (using jpegoptim $simulate_jpeg --max=85 --strip-all --size=50% --threshold=25% --verbose --total)" | tee -a $log
	echo -e "${red}There is $(find ./ -type f -iname '*'.jpeg -o -iname '*'.jpg 2>$logjpeg | wc -l ) JPEG pictures.${white}" | tee -a $log
	# read  # DEBUG
	( time jpegoptim $simulate_jpeg --max=85 --strip-all --size=75% --threshold=20% --verbose --total $(find ./ -type f -iname '*'.jpeg -o -iname '*'.jpg 2>$logjpeg ) ) | tee -a $log
	notify-send --icon=jpg "$(basename $0)" "I am done <b>compressing all JPEG pictures</b> (in $(pwd))."
	echo -e "${red}Compressing all PNG (*.png, *.PNG) pictures...${white} (using 'optipng $simulate_png -preserve -o1')" | tee -a $log
	echo -e "${red}There is $(find ./ -type f -iname '*'.png 2>$logpng | wc -l ) PNG pictures.${white}" | tee -a $log
	# read  # DEBUG
	# # time ( for i in $(find ./ -type f -iname '*'.png 2>$log ); do
	( time optipng $simulate_png -preserve -o1 $(find ./ -type f -iname '*'.png 2>$logpng ) ) | tee -a $log
	notify-send --icon=jpg "$(basename $0)" "I am done <b>compressing all PNG pictures</b> (in $(pwd))."
	# # done )
	echo -e "${red}Generating glisse index.html...${white}" | tee -a $log
	# read  # DEBUG
	generateglisse.sh | tee -a $log
	notify-send --icon=jpg "$(basename $0)" "I am done <b>generating glisse index.html</b> (in $(pwd))."
) && ( alert ; clear ; notify-send --icon=jpg "$(basename $0)" "And <b>now I am completely done :)</b> (in $(pwd)" )


# Comparison of the size
du -kh > du.log
tail -n1 du.log_ > /tmp/du.log_
tail -n1 du.log > /tmp/du.log
rm -vf du.log_
echo -e "${red}Size before | Size after${cyan}" | tee -a $log
diff -y /tmp/du.log_ /tmp/du.log
echo -e "${white}\n\nDone :)" | tee -a $log
