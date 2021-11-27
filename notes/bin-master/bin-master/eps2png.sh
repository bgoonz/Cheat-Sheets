#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: https://perso.crans.org/besson/bin/eps2png.sh
# Date: 03-02-2019
#
# Converting all input EPS files to PNG.
# Based on https://stackoverflow.com/questions/24032031/ghostscript-when-converting-eps-to-png-sometimes-quality-fails
#

for epsfile in $@; do
	pngfile="${epsfile%.eps}.png"
	echo -e "\nConverting '${epsfile}' to '${pngfile}'..."
	gs -q -dSAFER -dBATCH -dNOPAUSE -dNOPROMPT -dMaxBitmap=50000 -dEPSCrop -dAlignToPixels=0 -dGridFitTT=2 -sDEVICE=pngalpha -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -dUseCIEColor -r100x100 -dProcessColorModel=/DeviceRGB -sOUTPUTFILE="$pngfile" "$epsfile"
	ls -larth "${epsfile}" "${pngfile}"
done
