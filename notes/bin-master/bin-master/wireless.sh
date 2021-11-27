#!/usr/bin/env bash
# Review and Remove Wireless Access Points on DEB based Systems
#
# CPR : Jd Daniel :: Ehime-ken
# MOD : 2013-12-09 @ 12:27:02
# INP : $ wireless -{flag} {arg}
# From https://github.com/ehime/Bash-Tools/blob/master/TOYS/wireless.sh

# Use https://bitbucket.org/lbesson/bin/src/master/.color.sh to add colors in Bash scripts
[ -f ~/.color.sh ] && . ~/.color.sh
# TODO add colors

declare -r VERSION='1.2b'
declare -r net_dir='/etc/NetworkManager/system-connections'

if [ ! -d "${net_dir}" ]; then
    echo -e "${red}Warning: the directory ${net_dir} is not here...${white}"
fi

function list () {
    cd "${net_dir}"

    export count="$(find -type f | wc -l)"  # used in drop function
    echo -e "\n${green}Found ${count} wireless connections:${white}"
    find -type f | sed s_'./'_' - "'_ | sed s_'$'_'"'_
}

function drop () {
    # make sure that we have a working file and directory...
    cd "${net_dir}" ; [ -f "${OPTARG}" ] || { echo -e "\n${red}ERROR: Connection does not exist...${white}" ; exit 1; }

    checkroot

    # confirmation for removal
    printf "\nDo you want to delete \"${red}${OPTARG}${white}\" [y/N] " ; read -r resp

    # strtolower, and rm
    if [ X'y' == X"$(echo "${resp}" | awk ' {print tolower($0)} ')" ]; then
        rm -i "${net_dir}/${OPTARG}"
    fi
}

function flush () {
    # make sure that we have a directory with files...
    cd "${net_dir}" ; list ; [ 0 -ge "${count}" ] && { echo -e "${red}ERROR: Exiting, Nothing to flush...${white}" ;  exit 1 ; }

    checkroot

    # confirmation for removing all files
    printf "\n${red}All Wireless Connections will be removed${white}, continue? [y/N] " ; read -r resp

    # strtolower, and rm
    if [ X'y' == X"$(echo "${resp}" | awk ' {print tolower($0)} ')" ]; then
        rm -i "${net_dir}"/*
    fi
}

function version () {
    echo -e "\nwireless (GNU wireless network purge) v${VERSION}"
    echo -e "\nCopyright (C) 2013 Hydra Code, LLC."
    echo -e "License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.\nThis is free software: you are free to change and redistribute it.\nThere is NO WARRANTY, to the extent permitted by law."
    echo -e "\nWritten by Jd Daniel (Ehime-ken) http://github.com/ehime"
}

function help () {
    echo -e "\nUsage: wireless [OPTION]... [FILE]..."
    echo -e "\n${blue}List, remove single or flush the contents of your Wireless Network Manager${white}"
    echo -e "\nThe options below may be used to perform the above actions, this program will only"
    echo -e "  run a single flag or parameter at a time. Flag chaining is only available for ${yellow}-d${white}\n"
    echo -e "  ${yellow}-l${white}, ${yellow}--list${white} \t\t List the contents of your 'Network Manager'"
    echo -e "  ${yellow}-d${white}, ${yellow}--drop${white} [conn] \t Drop a single (or multiple) wireless connections"
    echo -e "  ${yellow}-f${white}, ${yellow}--flush${white} \t\t Flush all wireless connections."
    echo -e "      ${yellow}--help${white} \t\t Display this help menu and exit"
    echo -e "      ${yellow}--version${white} \t Display version information and exit"
}

function checkroot () {
    # If the user is not root
    if [ X"$(id -u)" != X"0" ]; then
        echo -e "\n${red}ERROR: This script must be run as root${white} (${White}${Bblack}'sudo $0'${reset}${white})" 1>&2
        help
        exit 1
    fi
}

if [ X"$*" = X ]; then
    help
    echo
    version
    exit 0
fi

# no long-opts supported except --help
while getopts ':hvld:f-:' OPT; do
    case $OPT in
        h)
            help
        ;;
        v)
            version
        ;;
        l)
            list
        ;;
        d)
            dirList="${dirList} $OPTARG"
            drop
        ;;
        f)
            flush
        ;;
        -) #long option
             case $OPTARG in
                    list)     list    ;;
                    drop)     drop    ;;
                    flush)    flush   ;;
                    help)     help    ;;
                    version)  version ;;
                    *)
                        echo -e "\n${red}ERROR: Unknown flag supplied ${OPTARG}${white}\nTry ${White}${Bblack}wireless --help${reset}${white}" ; exit 1
                    ;;
             esac
        ;;
        : )
            echo -e "\nMissing option argument for -$OPTARG" >&2 ; exit 1
        ;;
        * )
            echo -e "\n${red}ERROR: Unknown flag supplied ${OPTARG}${white}\nTry ${White}${Bblack}wireless --help${reset}${white}" ; exit 1
        ;;
    esac
done
shift $(($OPTIND - 1))
