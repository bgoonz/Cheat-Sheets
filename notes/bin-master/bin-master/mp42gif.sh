#!/usr/bin/env bash
# author: Lilian BESSON
# email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# date: 08-05-2015.
# web: https://bitbucket.org/lbesson/bin/src/master/mp4_to_gif.sh
#
# Convert a MP4 movie to a GIF animated picture..
#
# Usage: mp4_to_gif.sh movie1.mp4 [movie2.mp4 [..]]
#
# Example: mp4_to_gif.sh mysmallmovie.mp4
# Source: http://dtbaker.net/random-linux-posts/convert-video-avi-mpeg-mp4-to-a-gif-animation-on-linux/
#
# Licence: GPLv3 (http://perso.crans.org/besson/LICENSE.html)
#
mkdir -p /tmp/gif/frames/
echo "Deleting everything in /tmp/gif/*.gif?"
rm -rvI /tmp/gif/*.gif

for infile in "$@"; do
    echo -e "${green}Working on${white} '${infile}' :"

    echo "Deleting everything in /tmp/gif/frames/*.gif?"
    rm -rvI /tmp/gif/frames/*.gif

    if [ "${infile%.mp4}.mp4" != "${infile}" ]; then
        echo -e "${red}Wrong file:${white}'${infile}' is not a MP4 video."
        exit 2
    fi

    outfile="${infile%.mp4}.gif"

    if [ -f "${outfile}" ]; then
        echo -e "${yellow}Outfile '${outfile}' was already present.${white} I moved it to /tmp/gif/"
        mv -vf "${outfile}" /tmp/
    fi

    small_outfile="$(basename "${outfile}")"
    echo -e "${blue}Small outfile is:${white} '${small_outfile}'."

    # ffmpeg -i "$infile" -r 10 -s 711x400 /tmp/gif/frames/out%04d.gif
    echo -e "${magenta}Launching: ${black}'ffmpeg -i \"$infile\" -r 10 /tmp/gif/frames/out%04d.gif'${white} :"
    time ffmpeg -i "$infile" -r 10 /tmp/gif/frames/out%04d.gif

    # Combine these images together into a GIF animation:
    echo -e "${magenta}Launching: ${black}'gifsicle -delay=10 -loop /tmp/gif/frames/*.gif > \"/tmp/${small_outfile}\"'${white} :"
    gifsicle --careful --delay=10 -loop --merge /tmp/gif/frames/*.gif > "/tmp/${small_outfile}"

    # Optimise the GIF animation so the file size is smaller:
    # echo -e "${magenta}Launching: ${black}'convert -layers Optimize \"/tmp/${small_outfile}\" \"${outfile}\"'${white} :"
    # convert -layers Optimize "/tmp/${small_outfile}" "${outfile}"
done
