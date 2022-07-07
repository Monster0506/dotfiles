#! /usr/bin/env bash
# some useful functions and aliases

gplusplus() {
    if [ -z "$1" ]; then
        echo "Usage: g++ <file>"
        return
    fi
    # strip extention and save it
    local file=${1%.*}
    \g++ -o $file $1 && ./$file
}

md() {
    pandoc "${1:-README.md}" | lynx -stdin
}
clock() {
    # display a fancy clock using figlet

    # get the current time
    time=$(date +"%r")
    # create the clock with a border around it
    figlet -f big -w 80 -c "$time"

}
me() {
    echo -e "
$red███╗░░░███╗░█████╗░███╗░░██╗░██████╗████████╗███████╗██████╗░░█████╗░███████╗░█████╗░░█████╗░ ████╗░████║██╔══██╗████╗░██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔═══╝░
$coldblue██╔████╔██║██║░░██║██╔██╗██║╚█████╗░░░░██║░░░█████╗░░██████╔╝██║░░██║██████╗░██║░░██║██████╗░
██║╚██╔╝██║██║░░██║██║╚████║░╚═══██╗░░░██║░░░██╔══╝░░██╔══██╗██║░░██║╚════██╗██║░░██║██╔══██╗
$smoothgreen██║░╚═╝░██║╚█████╔╝██║░╚███║██████╔╝░░░██║░░░███████╗██║░░██║╚█████╔╝██████╔╝╚█████╔╝╚█████╔╝
╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░╚════╝░╚═════╝░░╚════╝░░╚════╝░
    "

}
whatTime() {
    Year=$(date +%Y)
    Month=$(date +%m)
    Day=$(date +%d)
    Hour=$(date +%H)
    Minute=$(date +%M)
    Second=$(date +%S)
    # echo `date`
    figlet -f big -w 80 -c "$Day-$Month-$Year"
    clock
}
up() {
    for i in $(seq 1 $1); do
        cd ../
    done
}

randomname() {
    for FILE in "$@"; do
        BASE="${FILE%.*}"
        EXT="${FILE#$BASE}"
        EXT="${EXT#.}" # correctly deal with names without extensions

        # retry arbitrarily many times on (unlikely) collision
        while true; do
            NEW_BASE="$RANDOM$RANDOM$RANDOM" # 32767^3 (ish) possibilities
            if [ -n "$EXT" ]; then
                NEW_FILE="$NEW_BASE.$EXT"
            else
                NEW_FILE="$NEW_BASE"
            fi

            # only write out if there's not already a file with that name
            # (otherwise, try again)
            if [ ! -f "$NEW_FILE" ]; then
                mv -f -- "$FILE" "$NEW_FILE"
                break
            fi
        done
    done
}
resetpythonvenv() {
    if [ ! -z "$VIRTUAL_ENV" ]; then
        echo "Deactivating..."
        deactivate
    else
        echo "No venv active, skipped 'deactivate' step."
    fi
    if [ -d "bin" ]; then
        echo "Nuking old virtual environment..."
        \rm -r bin
        \rm -r include
        \rm -r lib
        \rm pyvenv.cfg
    else
        echo "No 'bin' directory present, skipped nuking step."
    fi
    echo "Setting up a fresh virtual environment..."
    python3 -m venv .
    echo "Activating..."
    source bin/activate
    if [ -f "requirements.txt" ]; then
        echo "Reinstalling from requirements.txt..."
        pip3 install -r requirements.txt
    else
        echo "No 'requirements.txt' found, skipped reinstall step."
    fi
}
# Bash To Extract File Archives Of Various Types

extract() {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    else
        for n in "$@"; do
            if [ -f "$n" ]; then
                case "${n%,}" in
                *.cbt | *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
                    tar xvf "$n"
                    ;;
                *.lzma) unlzma ./"$n" ;;
                *.bz2) bunzip2 ./"$n" ;;
                *.cbr | *.rar) unrar x -ad ./"$n" ;;
                *.gz) gunzip ./"$n" ;;
                *.cbz | *.epub | *.zip | *.xpi) unzip ./"$n" ;;
                *.z) uncompress ./"$n" ;;
                *.7z | *.apk | *.arj | *.cab | *.cb7 | *.chm | *.deb | *.dmg | *.iso | *.lzh | *.msi | *.pkg | *.rpm | *.udf | *.wim | *.xar)
                    7z x ./"$n"
                    ;;
                *.xz) unxz ./"$n" ;;
                *.exe) cabextract ./"$n" ;;
                *.cpio) cpio -id <./"$n" ;;
                *.cba | *.ace) unace x ./"$n" ;;
                *.zpaq) zpaq x ./"$n" ;;
                *.arc) arc e ./"$n" ;;
                *.cso) ciso 0 ./"$n" ./"$n.iso" &&
                    extract $n.iso && \rm -f $n ;;
                *)
                    echo "extract: '$n' - unknown archive method"
                    return 1
                    ;;
                esac
            else
                echo "'$n' - file does not exist"
                return 1
            fi
        done
    fi
}
marco() {
    #check if the variable $MARCODIR exists
    if [ -z "$MARCODIR" ]; then
        # if it doesn't, set it to an empty list
        MARCODIR=()
    fi
    # check if $MARCODIR is a list
    case $1 in
    "-h" | "--help")
        echo "marco [OPTION] [[NUM] <DIR>] "
        echo "    If no directory is specified, the current directory appended to the list of items"
        echo "    -h --help           Show this help message and exit"
        echo "    -w [NUM]            Show the list of marco directories, or the <NUM>Th directory"
        echo "    -n <NUM>            Set the current directory to the <NUM>Th item in the list"
        echo "    -d [NUM | DIR]      Delete the entire marco list, or the [NUM]Th item, or the [DIR] directory"
        # taken from https://github.com/westonruter/misc-cli-tools/blob/master/cddown
        echo "    -r <DIR>            Attempt to recurse through the currrent directory to a directory matching DIR. Goes to first result."
        echo "    -u <DIR>            Attempt to recurse through ancestor directories to a directory matching DIR. Goes to first result."
        ;;

    "-w")
        if [ -z "$MARCODIR" ]; then
            echo "marco: no marco directory set"
        else
            if [ -z $2 ]; then
                echo "Directories:"
                for ((i = 1; i <= ${#MARCODIR[@]}; i++)); do
                    echo " $i: ${MARCODIR[$i - 1]}"
                done
            else
                echo "marco: ${MARCODIR[$2 - 1]}"
            fi
        fi

        ;;

        # THIS SHOULD BE FIXED
        # NEED TO DO WHEN NO NUMBER IS PROVIDED,INSTEAD A FILEPATH
    "-d")

        if [ -z $2 ]; then
            MARCODIR=()
        else
            if [[ "$2" =~ $NUMBERRE ]]; then
                for i in "${MARCODIR[@]}"; do
                    if [[ $i == ${MARCODIR[$2 - 1]} ]]; then
                        echo "Unsetting ${MARCODIR[$2 - 1]}"
                        unset 'MARCODIR[$2 - 1]'
                    fi
                done
                #HERE
            else
                for i in "${!MARCODIR[@]}"; do
                    if [[ $2 == ${MARCODIR[$i]} ]]; then
                        unset 'MARCODIR[$i]'
                    fi
                done

            fi
        fi
        # remove whitespace
        for i in "${!MARCODIR[@]}"; do
            new_array+=("${MARCODIR[i]}")
        done
        MARCODIR=("${new_array[@]}")
        unset new_array
        ;;

    "-n")
        if [ -z "$2" ]; then
            echo "no argument given. use -h for help"
        else
            if [[ "$2" =~ $NUMBERRE ]]; then
                MARCODIR[$2 - 1]="$(pwd)"
                echo "${MARCODIR[$2 - 1]}"
            else
                echo "must be between 1 and 1000"
            fi
        fi
        ;;
    "-r")
        if [ -z "$2" ]; then
            echo "no argument given. use -h for help"
        else
            # First try exact match
            dir=$(find . -type d -name $2 -print -quit)

            # If exact match failed, try supplying wildcards
            if [[ ! $dir ]]; then
                dir=$(find . -type d -name \*$2\* -print -quit)
            fi

            # This is not the directory you are looking for!
            if [[ ! $dir ]]; then
                echo "Couldn't find any directory named '$2'" 1>&2
                return 1
            fi
            marco $(realpath $dir)
        fi
        ;;
    "-u")
        if [ -z "$2" ]; then
            echo "no argument given. use -h for help"
        else
            dir="$1"
            old=$(pwd)

            # Try matching the full segment in path name
            new=$(perl -pe "s{(.*/\Q$dir\E)(?=/|$).*?$}{\1};" <<<$old)
            # If failed, try partial match of segment
            if [ "$old" == "$new" ]; then
                new=$(perl -pe "s{(.*/[^/]*?\Q$dir\E[^/]*?)(?=/|$).*?$}{\1}" <<<$old)
            fi
            # No replacements done, so we failed
            if [ "$old" == "$new" ]; then
                echo "Can't find '$dir' among ancestor directories ($old == $new)." 1>&2
                return 1
            fi
            marco $(realpath $new)
        fi

        ;;
    *)

        if [ -z "$1" ]; then
            MARCODIR+=($(pwd))
            echo $(pwd)
        else
            if [ -d "$1" ]; then
                MARCODIR+=("$(realpath $1)")
                echo "marco: $1"
            else
                if [[ "$1" =~ $NUMBERRE ]]; then
                    if [ -z "$2" ]; then
                        MARCODIR[$1 - 1]=$(pwd)
                        echo "marco: ${MARCODIR[$1 - 1]}"
                    else
                        if [ -d "$2" ]; then
                            MARCODIR[$1 - 1]="$2"
                        else
                            echo "$2 is not a directory"
                        fi
                    fi
                else
                    echo "must be between 1 and 1000"
                fi
            fi
        fi
        ;;
    esac
}

polo() {
    case $1 in
    "-h" | "--help")
        echo "polo [OPTION] [NUM | DIR [b | back]] "
        echo "    -h --help           Show this help message and exit"
        echo "    -w [NUM]            Show the list of marco directories, or the <num>th directory"
        echo "    -d [NUM | DIR]      Delete the entire marco list, or the [NUM]Th item, or the [DIR] directory"
        echo "    back | b            Move back a directory"
        echo "    -r [DIR]            Attempt to recurse through the currrent directory to a directory matching dir. Goes to first result."
        echo "    -u [DIR]            Attempt to recurse through ancestor directories to a directory matching dir. Goes to first result."

        ;;
    "-w")
        marco -w
        ;;
    "-d")
        marco -d "$2"
        ;;
    "b" | "back")
        cd ../
        ;;
    "-r")
        if [ -z "$2" ]; then
            echo "no argument given. use -h for help"
        else
            # First try exact match
            dir=$(find . -type d -name $2 -print -quit)

            # If exact match failed, try supplying wildcards
            if [[ ! $dir ]]; then
                dir=$(find . -type d -name \*$2\* -print -quit)
            fi

            # This is not the directory you are looking for!
            if [[ ! $dir ]]; then
                echo "Couldn't find any directory named '$2'" 1>&2
                return 1
            fi
            polo $(realpath $dir)
        fi
        ;;
    "-u")
        if [ -z "$2" ]; then
            echo "no argument given. use -h for help"
        else
            dir="$2"
            old=$(pwd)

            # Try matching the full segment in path name
            new=$(perl -pe "s{(.*/\Q$dir\E)(?=/|$).*?$}{\1};" <<<$old)
            # If failed, try partial match of segment
            if [ "$old" == "$new" ]; then
                new=$(perl -pe "s{(.*/[^/]*?\Q$dir\E[^/]*?)(?=/|$).*?$}{\1}" <<<$old)
            fi
            # No replacements done, so we failed
            if [ "$old" == "$new" ]; then
                echo "Can't find '$dir' among ancestor directories ($old == $new)." 1>&2
                return 1
            fi
            polo $(realpath $new)
        fi
        ;;
    *)
        if [ -z "$1" ]; then
            # if no arguments are provided, move to the first value of MARCODIR
            # check if I am inside MARCODIR[0]
            if [ -z $MARCODIR ]; then
                polo $HOME
            else
                if [ $(pwd) == "${MARCODIR[0]}" ]; then
                    if [ -z "${MARCODIR[1]}" ]; then
                        polo $HOME
                    else
                        cd "${MARCODIR[1]}"
                        echo "${MARCODIR[1]}"
                    fi
                else
                    cd "${MARCODIR[0]}"
                    echo "${MARCODIR[0]}"

                fi
            fi
        else
            if [ -d "$1" ]; then
                MARCODIR+=("$(realpath $1)")
                cd "$1"
                echo "$1"
            else
                if [[ "$1" =~ $NUMBERRE ]]; then
                    cd "${MARCODIR[$1 - 1]}"
                    echo "${MARCODIR[$1 - 1]}"
                else
                    echo "polo: '$1' - directory does not exist"
                fi
            fi

        fi
        ;;

    esac
}

zipExt() {
    if [ -z "$2" ] || [ -z "$1" ]; then
        return 1
    fi
    find . | egrep "\.($1)$" | zip -@ "$2".zip
}

findInFiles() {
    case "$1" in
    "-h" | "--help")
        echo "findInFiles [filePath] [string]"
        echo "    --help -h: print this help"
        ;;
    *)
        if [ -z "$1" ]; then
            echo "You must have 2 paramaters."
            echo "see -h or --help for options"
        else
            if [ -z "$2" ]; then
                echo "You must include the second paramater."
                echo "see -h or --help for options"
            else
                grep -rnw "$1" -e "$2"
            fi
        fi
        ;;
    esac
}

weather() {

    case "$1" in
    "-h" | "--help")
        echo "weather [city]"
        echo "    --help  -h:  print this help"
        echo "    --pager -p: pipe the output to a pager"
        echo "    --color -c: colorize the output"
        ;;
    *)
        if [ -z "$1" ]; then
            echo "You must have a city name."
            echo "see -h or --help for options"
        else
            case "$2" in
            "-c" | "--color")
                eval "curl http://wttr.in/$1" | lolcat
                ;;
            *)
                eval "curl http://wttr.in/$1"
                ;;
            esac
        fi
        ;;
    esac
}

cht() {
    case "$1" in
    "-h" | "--help")
        echo "cht [string]"
        echo "    --help -h: print this help"
        ;;
    *)
        if [ -z "$1" ]; then
            echo "You must have a string to search for."
            echo "see -h or --help for options"
        else
            case "$2" in
            "-c" | "--color")
                curl -s "https://cht.sh/$1" | lolcat
                ;;
            *)
                curl -s "https://cht.sh/$1"
                ;;
            esac

        fi
        ;;
    esac
}
hash git &>/dev/null
if [ $? -eq 0 ]; then
    diff() {
        git diff --no-index --color-words "$@"
    }
fi

# Create a data URL from a file
dataurl() {
    local mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

fs() {
    if du -b /dev/null >/dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* ./*
    fi
}
targz() {
    local tmpFile="${@%/}.tar"
    tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

    size=$(
        stat -f"%z" "${tmpFile}" 2>/dev/null # macOS `stat`
        stat -c"%s" "${tmpFile}" 2>/dev/null # GNU `stat`
    )

    local cmd=""
    if ((size < 52428800)) && hash zopfli 2>/dev/null; then
        # the .tar file is smaller than 50 MB and Zopfli is available; use it
        cmd="zopfli"
    else
        if hash pigz 2>/dev/null; then
            cmd="pigz"
        else
            cmd="gzip"
        fi
    fi

    echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…"
    "${cmd}" -v "${tmpFile}" || return 1
    [ -f "${tmpFile}" ] && rm "${tmpFile}"

    zippedSize=$(
        stat -f"%z" "${tmpFile}.gz" 2>/dev/null # macOS `stat`
        stat -c"%s" "${tmpFile}.gz" 2>/dev/null # GNU `stat`
    )

    echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully."
}

how() {
    echo "Whereis:"
    whereis "$1" | cut -d ":" -f 2
    echo "Type: "
    type "$1"
    echo "Which: "
    which "$1"
    echo "Path: "
    #search through each folder in the path variable to find "$1"
    for folder in $(echo $PATH | tr ":" "\n"); do
        for filename in $folder/*; do
            echo $filename | grep "$1"
        done
    done

}

server() {
    local port=${1:-8080}
    echo $port
    xdg-open "http://localhost:$port" &
    python3 -m http.server $port

}
