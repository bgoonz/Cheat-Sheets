#!/usr/bin/env bash
# Author: Lilian BESSON, (C) 2016-oo
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 19-08-2016.
# Web: https://bitbucket.org/lbesson/bin/src/master/latexstats.sh
#
# Prints some statistics about the number of theorem, proofs etc in a LaTeX document.
#
# Usage: latexstats.sh [FILE.tex [FILE.tex [...]]]
# If FILE is omitted, all the *.tex file at depth 1 are used
#
# Licence: MIT Licence (http://lbesson.mit-license.org).
version="0.2"

[ -f ~/.color.sh ] && . ~/.color.sh
# Add here options
NOANSI='false'
JUSTVERSION='false'
JUSTHELP='false'
for i in "$@"; do
    case "$i" in
        --noansi )
            NOANSI='true'
            [ -f ~/.nocolor.sh ] && . ~/.nocolor.sh
            shift
            ;;
        -v | --version )
            JUSTVERSION='true'
            shift
            ;;
        -h | --help | help )
            JUSTVERSION='true'
            JUSTHELP='true'
            shift
            ;;
    esac
done

# Copyrights and options
clear
if [ "X${JUSTHELP}" = "Xtrue" ]; then
    echo -e "\nUsage: latexstats.sh [FILE.tex [FILE.tex [...]]]"
    echo -e "If FILE is omitted, all the *.tex file at depth 1 are used"
fi
if [ "X${JUSTVERSION}" = "Xtrue" ]; then
    echo -e "${green}$0 v${version} : copyright (C) 2016 Lilian Besson"
    echo -e "  You can find it online (https://bitbucket.org/lbesson/bin/src/master/what-did-i-do-yesterday.sh)"
    echo -e "  This is free software, and you are welcome to redistribute it under certain conditions."
    echo -e "  This program comes with ABSOLUTELY NO WARRANTY; for details see http://lbesson.mit-license.org${white}"
    exit 0
fi

# Arrays
declare -a environments
environments=( defn theorem proof lemma proposition corollary remark warning example examples block exampleblock alertblock )
echo -e "- There is ${yellow}${#environments[@]}${white} different environments that I am aware of.\n"
declare -a envslabels
envslabels=( def thm proof lem prop cor rmk warning ex ex blk eblk ablk )

declare -a parts
parts=( section subsection subsubsection subsubsubsection paragraph )
echo -e "- There is ${yellow}${#parts[@]}${white} different kind of sections that I am aware of.\n"
declare -a partslabels
partslabels=( sec sub ssub sssub par )

# Args
if [ "X$@" = "X" ]; then
    echo -e "${red}Warning:${white} no argument, I am using all the .tex files in the current directory (max depth 1)"
    args=$(find -maxdepth 1 -iname '*'.tex)
else
    args=$@
fi

for latexfile in $args; do
    echo -e "\n\nFor the file ${u}${green}${latexfile}${white}${U} :"

    echo -e "${u}# For sections:${U}"
    for index in $(seq 0 $(( ${#parts[@]} - 1 )) ); do
        sec=${parts[index]}
        label=${partslabels[index]}
        # echo -e "sec = $sec, label = $label"  # DEBUG
        nbwithstar=$(grep -o -c \\\\${sec}\\\*\{ "${latexfile}")
        if [ $nbwithstar -gt 0 ]; then
            echo -e " - There is ${cyan}${nbwithstar}${white} part(s) ${green}without${white} number ${magenta}${sec}*${white}."
            nblabels=$(grep -o -c label\{"${label}" "${latexfile}")
            if [ $nblabels -gt 0 ]; then
                echo -e "     And ${cyan}${nblabels}${white} out of ${nbwithstar} have labels ('${black}${label}${white}')."
                if [ $nblabels -lt $nbwithstar ]; then
                    missinglabels=$(( $nbwithstar - $nblabels ))
                    echo -e "        ${red}Warning: ${missinglabels}${white} part(s) ${magenta}${sec}${white} ${yellow}do not have a label${white}..."
                fi
            fi
            nbrefs=$(grep -o -c ref\{"${label}" "${latexfile}")
            if [ $nbrefs -gt 0 ]; then
                echo -e "     And they are cited ${blue}${nbrefs}${white} times..."
            fi
        fi
        nbwithoutstar=$(grep -o -c \\\\${sec}\{ "${latexfile}")
        if [ $nbwithoutstar -gt 0 ]; then
            echo -e " - There is ${cyan}${nbwithoutstar}${white} part(s) ${green}with${white} number ${magenta}${sec}${white}."
            nblabels=$(grep -o -c label\{"${label}" "${latexfile}")
            if [ $nblabels -gt 0 ]; then
                echo -e "     And ${cyan}${nblabels}${white} out of ${nbwithoutstar} have labels ('${black}${label}${white}')."
                if [ $nblabels -lt $nbwithoutstar ]; then
                    missinglabels=$(( $nbwithoutstar - $nblabels ))
                    echo -e "        ${red}Warning: ${missinglabels}${white} part(s) ${magenta}${sec}${white} ${yellow}do not have a label${white}..."
                fi
            fi
            nbrefs=$(grep -o -c ref\{"${label}" "${latexfile}")
            if [ $nbrefs -gt 0 ]; then
                echo -e "     And they are cited ${blue}${nbrefs}${white} times..."
            fi
        fi
    done

    echo -e "${u}# For environments:${U}"
    for index in $(seq 0 $(( ${#environments[@]} - 1 ))); do
        env=${environments[index]}
        label=${envslabels[index]}
        nb=$(grep -o -c begin\{"${env}"\} "${latexfile}")
        if [ $nb -gt 0 ]; then
            echo -e " - There is ${cyan}${nb}${white} environment(s) ${magenta}${env}${white}."
            nbend=$(grep -o -c end\{"${env}" "${latexfile}")
            if [ $nbend -lt $nb ]; then
                missingends=$(( $nb - $nbend ))
                echo -e "        ${red}Warning: ${missingends}${white} environment(s) ${magenta}${env}${white} ${red}do not have an 'end' tag${white}..."
            elif [ $nbend -gt $nb ]; then
                missingbegins=$(( $nbend - $nb ))
                echo -e "        ${red}Warning: ${missingbegins}${white} environment(s) ${magenta}${env}${white} ${red}do not have an 'begin' tag${white}..."
            fi
            nblabels=$(grep -o -c label\{"${label}" "${latexfile}")
            if [ $nblabels -gt 0 ]; then
                echo -e "     And ${cyan}${nblabels}${white} out of ${nb} have labels ('${black}${label}${white}')."
                if [ $nblabels -lt $nb ]; then
                    missinglabels=$(( $nb - $nblabels ))
                    echo -e "        ${red}Warning: ${missinglabels}${white} environment(s) ${magenta}${env}${white} ${yellow}do not have a label${white}..."
                fi
            fi
            nbrefs=$(grep -o -c ref\{"${label}" "${latexfile}")
            if [ $nbrefs -gt 0 ]; then
                echo -e "     And they are cited ${blue}${nbrefs}${white} times..."
            fi
        fi
    done
    echo -e "${u}# For equations:${U}"
    for env in equation[^\\\*] equation\\\* eqnarray[^\\\*] eqnarray\\\* align[^\\\*] align\\\*
    do
        nb=$(grep -o -c begin\{"${env}" "${latexfile}")
        if [ $nb -gt 0 ]; then
            echo -e " - There is ${cyan}${nb}${white} environment(s) ${magenta}${env}${white}."
        fi
        nbend=$(grep -o -c end\{"${env}" "${latexfile}")
        if [ $nbend -ne $nb ]; then
            echo -e "        ${red}Warning${white} some environment(s) ${magenta}${env}${white} do not have a ending tag."
        fi
    done
    label="eq"
    nblabels=$(grep -o -c label\{"${label}" "${latexfile}")
    if [ $nblabels -gt 0 ]; then
        echo -e "     And ${cyan}${nblabels}${white} equations have labels ('${black}${label}${white}')."
    fi
    nbrefs=$(grep -o -c ref\{"${label}" "${latexfile}")
    if [ $nbrefs -gt 0 ]; then
        echo -e "     And they are cited ${yellow}${nbrefs}${white} times..."
    fi
    echo -e "${u}# For equations with \\$\\$:${U}"
    for pattern in \\$\\$
    do
        nbdoubledollar=$(grep -o -c ${pattern} "${latexfile}")
        if [ $nbdoubledollar -gt 0 ]; then
            nbdoubledollar=$(( nbdoubledollar / 2 ))
            echo -e " - There is ${cyan}${nbdoubledollar}${white} equations(s) starting with ${magenta}${pattern}${white}."
        fi
    done
    echo -e "${u}# For equations with \\$:${U}"
    for pattern in \\$
    do
        nbdollar=$(grep -o -c ${pattern} "${latexfile}")
        if [ $nbdollar -gt 0 ]; then
            nbdollar=$(( nbdollar - nbdoubledollar ))
            echo -e " - There is ${cyan}${nbdollar}${white} equations(s) starting with ${magenta}${pattern}${white}."
        fi
    done
done

echo -e "TODO: finish this script $0"
# End of latexstats.sh
