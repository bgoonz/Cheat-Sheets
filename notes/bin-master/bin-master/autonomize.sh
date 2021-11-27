#!/usr/bin/env bash
# By: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Date: 09-12-2014
#
# autonomize.sh, a small tool to be used with autonomize.sh to produce autonomous latex document from autotex-powered document (it adds all the necessary headers)
#
# Online: https://bitbucket.org/lbesson/bin/src/master/autonomize.sh
#
# More informations on autotex here: https://bitbucket.org/lbesson/bin/src/master/autotex
#
# Example of a LaTeX2e template to use with autonomize.sh :
# (http://perso.crans.org/besson/publis/latex/template_minimalist.tex)
#
# Licence: [GPLv3](http://perso.crans.org/besson/LICENCE.html)
#
version='0.4'

justClean="false"
doNothing="false"
batch="false"
compile="false"

clear
# echo -e "# Arguments are: ${magenta}\n$@${white}\n\n"
oridir="$(pwd)"

# Options parsing
for arg in "$@"; do
    case "$arg" in
        -v|-version|--version)
            echo -e "autonomize.sh $version"
            exit 0
            ;;
        -h|-help|--help)
            echo -e "${green}autonomize.sh${white} -help | [options]"
            echo -e ""
            echo -e "Produce autonomous latex document from autotex-powered document (it adds all the necessary headers)."
            echo -e ""
            echo -e "Help:"
            echo -e "    ${yellow}-h${white}           to print this help message (and quit)."
            echo -e "    ${yellow}-v${white}           to print just the version of strapdown2pdf, and quit."
            echo -e ""
            echo -e "Options:"
            echo -e "    ${yellow}-c|-clean${white}   just cleaning the source."
            echo -e "    ${yellow}-b|-batch${white}     run without interactivity from the user."
            echo -e "    ${yellow}-p|-compile${white}  after making the file autonomous, compile it with two uses of pdflatex."
            echo -e "    ${yellow}-a|-noaction${white}   do nothing (just showing what will be done ?). FIXME"
            echo -e ""
            echo -e "autonomize.sh v$version : Copyrights: (c) Lilian Besson 2011-2014."
            echo -e "Released under the term of the GPL v3 Licence (more details on http://perso.crans.org/besson/LICENSE.html)."
            echo -e "In particular, autonomize.sh is provided WITHOUT ANY WARANTY."
            exit 0
            ;;
        -a|-noaction|--noaction)
            echo -e "${cyan}Option '-a'${white}: do nothing (just showing)."  # FIXME
            doNothing="true"
            shift
            ;;
        -c|-clean|--clean)
            echo -e "${cyan}Option '-c'${white}: Just cleaning the source."
            justClean="true"
            shift
            ;;
        -b|-batch|--batch)
            echo -e "${cyan}Option '-b'${white}: Running without interactivity from the user."
            batch="true"
            shift
            ;;
        -p|-compile|--compile)
            echo -e "${cyan}Option '-p'${white}: After making the file autonomous, compile it with two uses of pdflatex."
            compile="true"
            shift
            ;;
     esac
done

template="${HOME}/template_minimalist.tex"

autonomize() {
    arg="${1}"

    if [ ! -f "$arg" ]; then
        echo -e "${red}The file ${cyan}${u}'${arg}'${U}${red} is NOT HERE : I skip it ...${white}"
        return 3
    fi

    if [ "$(grep "\\documentclass" "$arg")" ]; then
        echo -e "${red}The file ${cyan}${u}'${arg}'${U}${red} seems to be autonomous already (it contains a \\documentclass) : I skip it ...${white}"
        return 4
    fi

    f="$(basename "$1")"
    echo -e "${cyan}f = ${f}${white}"
    dossier="$(dirname "$1")"
    echo -e "${cyan}dossier = ${dossier}${white}"
    dossier="${dossier#./}"

    name="${arg%.en.tex}"
    name="${name%.fr.tex}"
    name="${name%.tex}"
    name="${name%__autonomize}"  # better !

    # Try to change the template regarding the language
    echo -e "We have f='${f}', and {f%.fr.tex}.fr.tex='${f%.fr.tex}.fr.tex', and {f%.en.tex}.en.tex='${f%.en.tex}.en.tex'..."
    langf="en"
    if [ "${f%.fr.tex}.fr.tex" = "$f" ]; then
        langf="fr"
        echo -e "Switching language from default (en) to ${green}fr (French)${white}..."
    elif [ "${f%.en.tex}.en.tex" = "$f" ]; then
        langf="en"
        echo -e "Switching language from default (en) to ${green}en (English)${white}..."
    fi

    out="${name}__autonomize.${langf}.tex"
    echo -e "${cyan}out = ${out}${white}"
    outf="$(basename "$out")"
    echo -e "${cyan}outf = ${outf}${white}"
    mv -vf "${out}" /tmp/

    ##
    ## Looking for Title, Size, PoliceSize
    ##
    # If PDF, find the appropriate TeX source
    f="${f//.pdf/.tex}"
    # If .tex was not there, add it
    f="${f%.tex}.tex"
    # Special hack. DURTY : FIXME !
    if [ "${dossier:0:6}" = "/home/" ]; then
        p="$(pwd)/"
    else
        p="$(pwd)/${dossier}"
    fi

    echo -e "Working with $u'$f'$U on $blue'$p'$white."
    cd "${p}"

    title="$(grep "%autotex% Titre: " "${p}/${f}")"
    title="${title#%autotex% Titre: }"
    if [ "X$title" = "X" ]; then
        title="$(grep "%autotex% Title: " "${p}/${f}")"
        title="${title#%autotex% Title: }"
    fi
    echo -e "Title: $green${title}$white"

    scale="$(grep "%autotex% Scale: " "${p}/${f}")"
    scale="${scale#%autotex% Scale: }"
    scale="${scale:-0.70}"
    echo -e "Scale: $green${scale}$white"

    policesize="$(grep "%autotex% PoliceSize: " "${p}/${f}")"
    policesize="${policesize#%autotex% PoliceSize: }"
    policesize="${policesize:-11pt}"
    echo -e "PoliceSize: $green${policesize}$white"
    ##
    ## End of detection for title, police size, scale
    ##

    ##
    ## First n lines of the template
    ##
    if [ "${justClean}" = "false" ]; then
        firstNlines=$(grep -n 'input{MyFileNameToChangeWithAutonomizeSh.tex}' "${template}" | grep -o "^[0-9]*")
        firstNlines=$(( firstNlines - 2 ))
        echo -e "${yellow}Using the first ${firstNlines} lines of the template ${template}."
        # cat "${template}" > "${out}"
        ## From autotex, change title, police size, scale
        if [ "${doNothing}" = "false" ]; then  # FIXME
            head -n ${firstNlines} "${template}" \
                | grep -v "^%%%%.*$" \
                | sed s/"scale=[0-9\.]*\]{geometry}"/"scale=${scale}]{geometry}"/ \
                | sed s/"11pt\]{article}"/"${policesize}]{article}"/ \
                | sed s#MyTitleToChangeWithAutonomizeSh#"${title}"# \
                > "${outf}"
        fi
    fi

    ##
    ## FIXME: + Tikz, + theorem, lemma, remark, remarque, demoBox, demoEn, etc

    echo -e "${yellow}From the file ${arg}, we change it a little bit, to make it more standard and more autonomous"
    ##
    ## Edit the input file
    ## From naereen.sty, slowly change every macros, clean up macro and non conventional files
    if [ "${doNothing}" = "false" ]; then  # FIXME
        cat "${p}/${f}" \
            | sed s/'\\begin{arab}'/'\\begin{enumerate}[label=(\\arabic*)]'/g \
            | sed s/'\\begin{roma}'/'\\begin{enumerate}[label=(\\roman*)]'/g \
            | sed s/'\\begin{Roma}'/'\\begin{enumerate}[label=(\\Roman*)]'/g \
            | sed s/'\\begin{enumalph}'/'\\begin{enumerate}[label=(\\alph*)]'/g \
            | sed s/'\\begin{enumAlph}'/'\\begin{enumerate}[label=(\\Alph*)]'/g \
            | sed s/'\\end{\(arab\|roma\|Roma\|enumalph\|enumAlph\)}'/'\\end{enumerate}'/g \
            | sed s/'\\arccosh'/'\\mathop{\\mathrm{arccosh}}'/g \
            | sed s/'\\arcsinh'/'\\mathop{\\mathrm{arcsinh}}'/g \
            | sed s/'\\arctanh'/'\\mathop{\\mathrm{arctanh}}'/g \
            | sed s/'=='/'\\mathrel{\\stackrel{\\smash{\\scriptscriptstyle\\mathrm{def}}}{=}}'/g \
            | sed s/'\\prof\(vijay\|arya\|satya\)\({}\)\?'/''/g \
            | sed s/'<==>'/'\\mathrel{\\Longleftrightarrow}'/g \
            | sed s/'--->'/'\\mathrel{\\Longleftrightarrow}'/g \
            | sed s/'-->'/'\\mathrel{\\longleftrightarrow}'/g \
            | sed s/'<=>'/'\\mathrel{\\Leftrightarrow}'/g \
            | sed s/'==>'/'\\mathrel{\\Rightarrow}'/g \
            | sed s/'<='/'\\leq'/g \
            | sed s/'>='/'\\geq'/g \
            | sed s/'\\geqlatex'/'>=latex'/g \
            | sed s/'\\leqlatex'/'<=latex'/g \
            | sed s/'|->'/'\\mathrel{\\mapsto}'/g \
            | sed s/'+oo'/'+\\infty'/g \
            | sed s/'-oo'/'-\\infty'/g \
            | sed s/'\\DUtransition\({}\)\?'/'\\hspace*{\\fill}\\hrulefill\\hspace*{\\fill}\\vskip 0.5\\baselineskip %% Horizontal line'/g \
            | grep -v "^%autotex%.*$" \
            | sed s/'\\ie'/'\\emph{i.e.}~'/g \
            | sed s/'\\eg'/'\\emph{e.g.}~'/g \
            | sed s/'\\ssi'/'\\textbf{ssi}~'/g \
            | sed s/'\\iff'/'\\textbf{iff}~'/g \
            | sed s/'\\it{'/'\\textit{'/g \
            | sed s/'\\tt{'/'\\texttt{'/g \
            | sed s/'\\bf{'/'\\textbf{'/g \
            | sed s/'\\sc{'/'\\textsc{'/g \
            | sed s/'\\todo{'/'\\textcolor{red}{'/g \
            | sed s/'\\inv{\(.*\)}'/'\\frac{1}{\1}'/g \
            | sed s/'\\inv{\(.*\)}'/'\\frac{1}{\1}'/g \
            | sed s/'\\inv{\(.*\)}'/'\\frac{1}{\1}'/g \
            | sed s/'\\e^'/'\\mathrm{e}^'/g \
            | sed s/'\\e '/'\\mathrm{e} '/g \
            | sed s/'\\dx'/'\\mathrm{d}x'/g \
            | sed s/'\\dy'/'\\mathrm{d}y'/g \
            | sed s/'\\dz'/'\\mathrm{d}z'/g \
            | sed s/'\\dt'/'\\mathrm{d}t'/g \
            | sed s/'\\E '/'\\exists '/g \
            | sed s/'\\V '/'\\forall '/g \
            | sed s/'\\Z'/'\\mathbb{Z}'/g \
            | sed s/'\\N'/'\\mathbb{N}'/g \
            | sed s/'\\R'/'\\mathbb{R}'/g \
            | sed s/'\\Q'/'\\mathbb{Q}'/g \
            | sed s/'\\C'/'\\mathbb{C}'/g \
            | sed s/'\\D'/'\\mathbb{D}'/g \
            | sed s/'\\K'/'\\mathbb{K}'/g \
            | sed s/'\\epsilon'/'\\varepsilon'/g \
            | sed s/'\\IR'/'\\mathbb{R}'/g \
            | sed s/'\\IC'/'\\mathbb{C}'/g \
            | sed s/'\\IQ'/'\\mathbb{Q}'/g \
            | sed s/'\\IZ'/'\\mathbb{Z}'/g \
            | sed s/'\\IN'/'\\mathbb{N}'/g \
            | sed s/'\\IF'/'\\mathbb{F}'/g \
            | sed s/'\\score{\([0-9\.]*\)}'/''/g \
            | sed s/'\\exer '/'\\item '/g \
            | sed s/'\\bonus '/'\\item (\textbf{Bonus:})'/g \
            >> "${outf}"
            # | sed s/'\\cosh'/'\\mathop{\\mathrm{cosh}}'/g \
            # | sed s/'\\sinh'/'\\mathop{\\mathrm{sinh}}'/g \
            # | sed s/'\\tanh'/'\\mathop{\\mathrm{tanh}}'/g \

        ## Closing documents
        if [ "${justClean}" = "false" ]; then
            echo -e "\n\\\\end{document}\n%% End of the document ${arg}" >> "${outf}"
        fi

        echo -e "${green}Done: new file is ${out}.${white}"
        if [ "${batch}" = "false" ]; then
            colordiff "${p}/${f}" "${outf}"
            subl "${outf}"
        fi

        if [ "${compile}" = "true" ]; then
            # cd "${p}"
            echo -e "${green}Compiling ${outf}${white}... (in pwd=${u}$(pwd)${U})${white}"
            head -n1 "${outf}"
            ( pdflatex -interaction=batchmode "${outf}" && pdflatex -interaction=batchmode "${outf}" &>/dev/null ) \
            || echo -e "${red} Problem with the file ${arg} converted to ${outf}"
            if [ -f "${outf%.tex}.pdf" -a "${batch}" = "false" ]; then
                evince "${outf%.tex}.pdf" &> /dev/null &
            fi
            if [ -f "${outf%.tex}.pdf" ]; then
                PDFCompress --no-notify "${outf%.tex}.pdf"
            fi
            mv -vf "${outf%.tex}.aux" "${outf%.tex}.out" "${outf%.tex}".synctex.gz* "${outf%.tex}.log" /tmp/
        fi

        notify-send "autonomize.sh" "Done for the file <b>${f}</b> --> <b>${out}</b>. $([ "${compile}" = "true" ] && echo "\nIt has been compiled to <b>${out%.tex}.pdf</b>") "
    fi
    cd "${oridir}"
}

autonomize "${1}"
shift
for finput in "$@"; do
    echo -e "\n\n---------------------------"
    # read # debug
    echo -e "${blue}Generating the next file..."
    autonomize "${finput}"
done

## End of autonomize.sh
