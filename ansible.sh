#!/bin/bash
########################################################
# Useful function to Get the current shell script path #
########################################################
realpath() {
    OURPWD=$PWD
    cd "$(dirname "$1")"
    LINK=$(readlink "$(basename "$1")")
    while [ "$LINK" ]; do
        cd "$(dirname "$LINK")"
        LINK=$(readlink "$(basename "$1")")
    done
    REALPATH="$PWD/$(basename "$1")"
    cd "$OURPWD"
    echo "$REALPATH"
}


#############################################
# Useful section to print the color in bash #
#############################################

# Colors
end="\033[0m"
black="\033[0;30m"
blackb="\033[1;30m"
white="\033[0;37m"
whiteb="\033[1;37m"
red="\033[0;31m"
redb="\033[1;31m"
green="\033[0;32m"
greenb="\033[1;32m"
yellow="\033[0;33m"
yellowb="\033[1;33m"
blue="\033[0;34m"
blueb="\033[1;34m"
purple="\033[0;35m"
purpleb="\033[1;35m"
lightblue="\033[0;36m"
lightblueb="\033[1;36m"

function black {
    echo -e "${black}${1}${end}"
}

function blackb {
    echo -e "${blackb}${1}${end}"
}

function white {
    echo -e "${white}${1}${end}"
}

function whiteb {
    echo -e "${whiteb}${1}${end}"
}

function red {
    echo -e "${red}${1}${end}"
}

function redb {
    echo -e "${redb}${1}${end}"
}

function green {
    echo -e "${green}${1}${end}"
}

function greenb {
    echo -e "${greenb}${1}${end}"
}

function yellow {
    echo -e "${yellow}${1}${end}"
}

function yellowb {
    echo -e "${yellowb}${1}${end}"
}

function blue {
    echo -e "${blue}${1}${end}"
}

function blueb {
    echo -e "${blueb}${1}${end}"
}

function purple {
    echo -e "${purple}${1}${end}"
}

function purpleb {
    echo -e "${purpleb}${1}${end}"
}

function lightblue {
    echo -e "${lightblue}${1}${end}"
}

function lightblueb {
    echo -e "${lightblueb}${1}${end}"
}

function colors {
    black "black"
    blackb "blackb"
    white "white"
    whiteb "whiteb"
    red "red"
    redb "redb"
    green "green"
    greenb "greenb"
    yellow "yellow"
    yellowb "yellowb"
    blue "blue"
    blueb "blueb"
    purple "purple"
    purpleb "purpleb"
    lightblue "lightblue"
    lightblueb "lightblueb"
}

function colortest {
    if [[ -n "$1" ]]; then
        T="$1"
    fi
    T='gYw'   # The test text

    echo -e "\n                 40m     41m     42m     43m\
    44m     45m     46m     47m";

    for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
        '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
        '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
        echo -en " $FGs \033[$FG  $T  "
        for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
        do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
        done
        echo;
    done
    echo
}

# https://github.com/mkropat/sh-realpath/blob/master/realpath.sh
realpath() {
    canonicalize_path "$(resolve_symlinks "$1")"
}

resolve_symlinks() {
    _resolve_symlinks "$1"
}

_resolve_symlinks() {
    _assert_no_path_cycles "$@" || return

    path=$(readlink -- "$1")
    if [ $? -eq 0 ]; then
        dir_context=$(dirname -- "$1")
        _resolve_symlinks "$(_prepend_dir_context_if_necessary "$dir_context" "$path")" "$@"
    else
        printf '%s\n' "$1"
    fi
}

_prepend_dir_context_if_necessary() {
    if [ "$1" = . ]; then
        printf '%s\n' "$2"
    else
        _prepend_path_if_relative "$1" "$2"
    fi
}

_prepend_path_if_relative() {
    case "$2" in
    /*) printf '%s\n' "$2" ;;
    *) printf '%s\n' "$1/$2" ;;
    esac
}

_assert_no_path_cycles() {
    target=$1
    shift

    for path in "$@"; do
        if [ "$path" = "$target" ]; then
            return 1
        fi
    done
}

canonicalize_path() {
    if [ -d "$1" ]; then
        _canonicalize_dir_path "$1"
    else
        _canonicalize_file_path "$1"
    fi
}

_canonicalize_dir_path() {
    (cd "$1" 2>/dev/null && pwd -P)
}

_canonicalize_file_path() {
    dir=$(dirname -- "$1")
    file=$(basename -- "$1")
    (cd "$dir" 2>/dev/null && printf '%s/%s\n' "$(pwd -P)" "$file")
}

# Optionally, you may also want to include:

### readlink emulation ###

readlink() {
    if _has_command readlink; then
        _system_readlink "$@"
    else
        _emulated_readlink "$@"
    fi
}

_has_command() {
    hash -- "$1" 2>/dev/null
}

_system_readlink() {
    command readlink "$@"
}

_emulated_readlink() {
    if [ "$1" = -- ]; then
        shift
    fi

    _gnu_stat_readlink "$@" || _bsd_stat_readlink "$@"
}

_gnu_stat_readlink() {
    output=$(stat -c %N -- "$1" 2>/dev/null) &&
        printf '%s\n' "$output" |
        sed "s/^‘[^’]*’ -> ‘\(.*\)’/\1/
            s/^'[^']*' -> '\(.*\)'/\1/"
    # FIXME: handle newlines
}

_bsd_stat_readlink() {
    stat -f %Y -- "$1" 2>/dev/null
}

SCRIPT=$(realpath $0)
SCRIPTPATH=$(dirname $SCRIPT)

cd ${SCRIPTPATH}
# run playbook.yml with verbose mode
ansible-playbook playbook.yml -vv