#!/usr/bin/env bash
#
# __author__ = 'Lilian BESSON'
# __email__ = 'Lilian.BESSON[AT]ens-cachan[DOT]fr'
# __date__ = '31-08-2013'
#
# A first try to automatically get a random citation
# from https://fr.wikiquote.org/wiki/*
#
# By default, it uses https://fr.wikiquote.org/wiki/Kaamelott/
#
# Find the most recent version here
# http://perso.crans.org/besson/publis/bin/quotes.sh
#
version='0.1'

# en -> https://en.wikiquote.org/wiki/
LANG='en'
# fr -> https://fr.wikiquote.org/wiki/
LANG='fr'

# If possible, use .color.sh (http://perso.crans.org/besson/publis/bin/.color.sh)
##[ -f ~/.color.sh ] && ( . ~/.color.sh ; clear )
[ -f ~/.color.sh ] && . ~/.color.sh

#
# Starting....
#
echo -e "${yellow}.: Lilian Besson presents :.$white$reset"
echo -e "Automatic wikiquote citation parser, v${version}.$white$reset"

#
# Default values for options
#
random="yes"
first="no"
number="1"
all="no"
WGET_VERBOSITY="-q" # FIXME -nv better ?

output="/tmp/quotes.txt"

#
# command line options
#
for i in "$@"; do
 case "$i" in
 -h|--help)
   echo -e "$green$0$white --help | [options] FILE [FILE2 [FILE3]...]"
   echo -e ""
   echo -e "Get citations from LANG.wikiquote.org/FILE"
   echo -e ""
   echo -e "Help:"
   echo -e "    ${yellow}--help$white		print this help message (and quit)."
   echo -e "Options:"
   echo -e "    ${yellow}-nv$white			median wget verbosity (default mode)."
   echo -e "    ${yellow}-v$white			increase wget verbosity."
   echo -e "    ${yellow}-q$white			make wget quiet."

   echo -e "    ${yellow}--random$white		get a random citation (default mode)."
   echo -e "    ${yellow}--first$white		get the first citation (quicker)."
   echo -e "    ${yellow}--english$white		set LANG to english (french is default)."
   echo -e "    ${yellow}--number I$white		get the I^th citation (experimental)."
   echo -e "    ${yellow}--all$white		get citations (slower), write them to ${black}/tmp/quotes.txt${white}."
   echo -e "    ${yellow}--output FILE$white	write citation(s) FILE instead of ${black}/tmp/quotes.txt${white}."
   echo -e ""
   echo -e "Examples:"
   echo -e " * $0 --random Kaamelott"
   echo -e " * $0 --all Kaamelott/Loth >/dev/null; cat /tmp/quotes.txt"
   echo -e " * $0 --all --output ~/kadoc.txt Kaamelott/Kadoc"
   echo -e ""
   echo -e "Copyrights: (c) Lilian Besson 2011-2013."
   echo -e "Released under the term of the GPL v3 Licence."
   echo -e "In particular, $0 is provide WITHOUT ANY WARANTY."
   shift
   exit 0
  ;;
 -r|--random)	random="yes"; echo -e "${cyan} option random found."; shift
  ;;
 -f|--first)	first="yes"; echo -e "${cyan} option first found."; random="no"; all="no"; shift
  ;;
 -a|--all)	all="yes"; echo -e "${cyan} option all found."; random="no"; first="no"; shift
  ;;
 -nv|--non-verbose)	WGET_VERBOSITY="-nv"; echo -e "${cyan} option nv found.";  shift
  ;;
 -v|--verbose)	WGET_VERBOSITY="-v"; echo -e "${cyan} option v found.";  shift
  ;;
 -q|--quiet)	WGET_VERBOSITY="-q"; echo -e "${cyan} option q found.";  shift
  ;;
 -e|--english)	LANG="en"; echo -e "${cyan} option english found.";  shift
  ;;
 -o|--output)	echo -e "${cyan} option output found."; shift; output="$1"; echo -e "${cyan} writing citations to ${black}$output${white}."; shift
  ;;
 -n|--number)	echo -e "${cyan} option number found."; shift; number="$1"; echo -e "${cyan} trying to find citation number ${black}$number${white}."; random="no"; shift
  ;;
 *)
  ;;
 esac
done

#
# File by file
#
for file in "$@"; do
  echo -e "For the argument ${magenta}$file${white}..."

#  url="http://$LANG.wikiquote.org/wiki/$file"
  url="http://$LANG.wikiquote.org/w/index.php?title=$file&printable=yes"
  echo -e "Trying the url ${magenta}${u}${url}${U}${white} :"

  out=/tmp/"${file//'/'/_}".html
  echo -e "Intermediate html file : ${black}$out${white}."

  wget "$WGET_VERBOSITY" -t 5 "$url" -O "$out"

  if [ "$?" != "0" ]; then
#   echo -e "${red}Error: continuing with the next file${white}"
   echo -e "${red}Error: wget failed to get the file ${magenta}${u}${url}${U}${white}."
#   continue
   exit 2
  fi

  outpure="${out%.html}.pure.html"
  echo -e "Searching for citations, writing the to ${black}$outpure${white}."

  #
  # Keeping only useful part of the header
  #
#  head -n 5 "$out" > "$outpure"
  cp "$out" "$outpure"
  echo -e "<!-- Modified from the file download at this url : $url -->\n</head>" >> "$outpure"

  ###grep -m 2000 -A 6 -B 1 "class=\"citation\"" "$out" | tail -n +2 >> "$outpure"

  #
  # Keeping useful part only
  #
#  nbegin=`grep -n "class=\"mw-headline\" id=\"Citations\">Citations" "$out" | grep -o ^[0-9]*`
#  cat "$out" | tail -q -n +$nbegin > "$outpure"~

#  nend=`grep -n "NewPP limit report" "$outpure"~ | grep -o ^[0-9]*`
#  nend=`grep -n "<div id=\"interProject\"" "$outpure"~ | grep -o ^[0-9]*`
#  cat "$outpure"~ | head -q -n $((nend - 3)) >> "$outpure"
# FIXME

  #
  # Removing useless lines
  #
  grep -v "<p><br /></p>" "$outpure" > "$outpure"~
  echo -e "<!-- Produce by a script made by Lilian BESSON, http://perso.crans.org/besson/bin/quotes.sh -->" > "$outpure"
  cat "$outpure"~ >> "$outpure"

  #
  # List of line number of citation (-1 +6)
  #
  lines=/tmp/lines_$$.quotes.sh
  echo -e "${white}Writing lines numbers to ${black}$lines${reset}."
  grep -n "class=\"citation\"" "$outpure" | grep -o ^[0-9]* > "$lines"
  echo -e "Results:${cyan}`wc \"$lines\" | grep -o \"^ [0-9]*\"` citation(s)${white} found in ${black}$outpure${white}."

  #
  # Now select one or all or one random citation
  #
  echo -e "Options: random=$random, first=$first, all=$all."

  [ "$random" = "yes" ] && ( echo -e "${blue} Shuffling citations...${white}" ; shuf "$lines" -o "$lines" )
  [ "$first" = "yes" ] && ( tail -n 1 "$lines" > "$lines"~ ; echo -e "${blue} Keeping only the first citation...${white}" ; mv -f "$lines"~ "$lines" )
  [ "$number" != "1" ] && ( cat "$lines" | sed -n "$number",+0p > "$lines"~ ; mv -f "$lines"~ "$lines" )

 #
 # Produce the last .html file with the chosen citations.
 #
 last="${out%.html}.last.html"
 rm -vf $last
 #head -n 8 "$outpure" > "$last" # FIXME

 for i in `cat "$lines"`; do
  echo -e "Line i=$i"
#  echo -e "`cat \"$outpure\"`" \
  cat "$outpure" \
   | sed -n $i,+5p \
   | sed s_'<p><span class="citation">'_'<span>@“'_ \
   | grep -v "<br>\|<ul>\|<li>\|</li>\|</ul>" \
   | sed s_'</span></p>'_'”</span><br />-- '_ \
    >> "$last"
 done

 if [ ! -f "$last" ]; then
  echo -e "${red}Error:${white} file ${black}$last${white} was not produced... Next ?"
  exit 3
 fi

 echo -e "${red}Done?${reset}"
 cat "$last"

 rm -fv "$output"

# html2rest "$last" \
#  | grep -v "\`.*\`_" \
#  | grep -v "~*" \
#  | tr \\n ' ' \
#  | sed s/'“'/'“\\n'/ \
#  | sed s/@/\n/ \
#  > "$output"

 html2rest "$last" \
  | tr \\n ' ' \
  | tr @ '\n' \
  > "$output"
 echo "" >> "$output"
 echo -e "${red}Output written to ${black}$output${white}..."

 echo -e "\n$green ------------------------------------------------------------- $reset"
 cat "$output"

 rm -fv "$lines" "$out" "$outpure" "$outpure"~ "$last"

done