#!/usr/bin/env /bin/bash
#
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 27-12-2015
#
# A script to convert a buntch of gif animated files to MP4 movies.
# Copyright (C) 2015 Lilian BESSON (lbesson at ens-cachan dot fr)
#
# Find the latest version on http://perso.crans.org/besson/bin/gif2mp4.sh
#
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program. If not, see <http://www.gnu.org/licenses/>,
#     or <http://perso.crans.org/besson/LICENSE>.
#
# Requires:
#  - convert (imagemagick),
#  - ffmpeg (or avconv).
#
# References:
#  - https://sonnguyen.ws/convert-gif-to-mp4-ubuntu/
#  - http://apple.stackexchange.com/a/103834
#
# TODO:
#  - add an argument to cycle X times over the input gif file, with the trick explained here http://video.stackexchange.com/a/12906
#
version="0.2"
wdir="/tmp/gif2mp4/frames/"
wbackup="/tmp/gif2mp4/backup/"

# If possible, use ~/.color.sh (http://perso.crans.org/besson/bin/.color.sh)
[ -f ~/.color.sh ] && ( . ~/.color.sh ; clear )

gif2mp4f (){
    olddir="$(pwd)"
    mkdir --parents "${wdir}"

    f="$(basename "$1")"
    dossier="$(dirname "$1")"
    # If MP4, find the appropriate gif source
    f="${f//.mp4/.gif}"
    # If .gif was not there, add it
    f="${f%.gif}.gif"
    dest="${f%.gif}.mp4"
    # Special hack. DURTY XXX
    if [ "${dossier:0:6}" = "/home/" ]; then
        p="$(pwd)/"
    else
        p="$(pwd)/${dossier}"
    fi

    echo -e "Working with ${u}'${f}'${U} on ${blue}'${p}'${white}."

    # echo -e "Starting, going to /tmp/gif2mp4/frames/..."
    # cd "${wdir}"

    if [ -f "${p}"/"${dest}" ]; then
        echo -e "WARNING: The file ${u}'${dest}'${U} (from ${blue}'${p}'${white}) is ${red}already present${white}"
        echo -e "${green}Backing up this file${white} to ${wbackup}..."
        echo -e cp -vf "${p}"/"${dest}" "${wbackup}"
    fi

    # You can use two programs, Imagemagick's convert command and ffmpeg, to do this.
    echo -e "\n${green}Converting the GIF file (${f}) to PNG frames...${white} (it can take a while)..."
    echo -e convert -coalesce "${p}"/"${f}" "${wdir}"frames%04d.png
    time convert -coalesce "${p}"/"${f}" "${wdir}"frames%04d.png

    # Then convert the pngs to a movie:
    echo -e "\n${green}Converting the PNG frames to a MP4 movie (${dest})...${white} (it can take a while)..."
    echo -e ffmpeg -r 10 -i "${wdir}"frames%04d.png -vcodec mjpeg -y "${p}"/"${dest}"
    time ffmpeg -r 10 -i "${wdir}"frames%04d.png -vcodec mjpeg -y "${p}"/"${dest}"
    # avconv -r 8 -i "${wdir}"/frames%04d.png -qscale 4 "${p}"/"${dest}"

    # echo -e "Done, going back to ${olddir}..."
    # cd "${olddir}"
}

# Use this function
log=/tmp/gif2mp4_$$.log
echo -e "$0 have been called with the arguments (after processing the options) : ${blue}$@${white}." | tee -a "${log}"

for i in "$@"; do
    # echo -e "Calling the function ${magenta}'gif2mp4f'${white} for the argument ${u}'${i}'${U} (on pwd = $(pwd))..." | tee -a "${log}"
    # gif2mp4f "$i" | tee -a "${log}"   # I don't use this complicated function anymore
    echo -e "Using ${magenta}'ffmpeg'${white} for the file ${u}'${i}'${U} (on pwd = $(pwd))..." | tee -a "${log}"
    echo -e "${warning}This can take a while...${white}"
    # This one-liner command is better! Cf. http://unix.stackexchange.com/a/294892
    echo ffmpeg -f gif -i "$i" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "${i%.gif}.mp4" | tee -a "${log}"
    time ffmpeg -f gif -i "$i" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "${i%.gif}.mp4" | tee -a "${log}"
    echo -e "Done for ${magenta}'gif2mp4f'${white} on ${u}'${i}'${U}..." | tee -a "${log}"
done

# echo -e "${red}Warning: Can I delete all the frames files?${white}"
# ls "${wdir}"frames*.png
# rm -rvI "${wdir}"frames*.png

# End of gif2mp4.sh
