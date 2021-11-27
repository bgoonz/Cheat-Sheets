#!/usr/bin/env bash
# author: Lilian BESSON
# email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# date: 21-01-2015.
# web: https://bitbucket.org/lbesson/bin/src/master/tree_html.sh
#
# Generate a HTML file showing a depth indented listing of files, with colours and hyperlink.
#
# Help: tree_html.sh [depth]
#
# Requires: the 'tree' command (http://mama.indstate.edu/users/ice/tree/)
#
# Licence: GPLv3 (http://perso.crans.org/besson/LICENSE.html)
#
version="1.0"
echo -e "tree_html.sh: starting..."

function generateHTMLtree() {
    # Depth
    depth="${1:-1}"
    # echo -e "tree_html.sh: working with depth = '${depth}'."

    # File or not file ? Give the option '-a' for all files, '-d' for directories, nothing for default
    # option="${2:--d}"
    option="${2}"
    # echo -e "tree_html.sh: working with option = '${option}'."

    if [ X"${option}" = X"-a" ]; then
        baseoutputfile=".all"
        typeoflisting="Listing of all files"
    elif [ X"${option}" = X"-d" ]; then
        baseoutputfile=".dirs"
        typeoflisting="Listing of directories"
    else
        baseoutputfile=".files"
        typeoflisting="Listing of dirs and files"
    fi
    # echo -e "tree_html.sh: working with baseoutputfile = '${baseoutputfile}'."

    # Title
    if [ X"$(hostname)" = X"zamok" ]; then
        webpath="http://perso.crans.org/besson/"
    else
        webpath="http://jarvis/"
    fi
    defaulttitle="${typeoflisting} @ ${webpath} (depth ${depth})"
    title="${3:-$defaulttitle}"
    # echo -e "tree_html.sh: working with title = '${title}'."

    # Output file
    defaultoutputfile="${baseoutputfile}_${depth}.html"
    outputfile="${4:-$defaultoutputfile}"
    # echo -e "tree_html.sh: working with outputfile = '${outputfile}'."

    # Start
    tree -T "${title}" -q -p -h -D -F -t -C ${option} \
        --charset UTF-8 -L "${depth}" -H . \
        | sed s_"</a>/"_"</a>/<br>"_g \
        | sed s_"<br><br>"_"<br>"_g \
        | sed s@"<p class=\"VERSION\">"@"<p class=\"VERSION\">Generated the $(date)<br>By a <a href=\"https://bitbucket.org/lbesson/bin/src/master/tree_html.sh\" title=\"On Bitbucket.org !\">free and open source Bash script</a>, written by <a href=\"http://perso.crans.org/besson/\">Lilian Besson</a>.<br>"@ \
        > "${outputfile}" \
        && echo -e "- ${green}Success${white}: file '${blue}${u}${outputfile}${U}${white}' well written, option '${magenta}${option}${white}' and depth='${yellow}${depth}${white}')." \
        | tee -a /tmp/tree_html.log
}

# Find the depth
depth="${1:-1}"
if [ $depth -gt 6 ]; then
    echo -e "${red}Please use a depth <= 6.${white}"
    depth=6
fi

echo -e "${black}tree_html.sh${white}: a list of HTML files showing a depth indented (upto the depth '${yellow}${depth}${white}') listing of files, with colours and hyperlink will be produced in the directory '${blue}${u}$(pwd)${U}${white}'."

# Use that function
for i in $(seq 1 ${depth}); do
    generateHTMLtree "$i" -d && generateHTMLtree "$i"
done
echo -e "\ntree_html.sh: YES, a list of HTML files (from depth=1 to depth=${depth}) has been produced:"
ls -larth .files_*.html .dirs_*.html .all_*.html 2>/dev/null

echo -e "\ntree_html.sh v$version : (C) Lilian Besson 2015."
# echo -e "Released under the term of the GPL v3 Licence (more details on http://perso.crans.org/besson/LICENSE.html)."
# echo -e "In particular, tree_html.sh is provided WITHOUT ANY WARANTY."
