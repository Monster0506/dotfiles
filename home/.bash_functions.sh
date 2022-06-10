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

$red███╗░░░███╗░█████╗░███╗░░██╗░██████╗████████╗███████╗██████╗░░█████╗░███████╗░█████╗░░█████╗░
████╗░████║██╔══██╗████╗░██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔═══╝░
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
        rm -r bin
        rm -r include
        rm -r lib
        rm pyvenv.cfg
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
                *.cbz | *.epub | *.zip) unzip ./"$n" ;;
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
        echo "marco [num] [-n <num>] [directory] [-h --help] [-w [num]] "
        echo "    If no directory is specified, the current directory is used as the initial item."
        echo "    -h --help    Show this help message and exit"
        echo "    [num]        Sets the current directory to the specified number"
        echo "    -w [num]     Show the list of marco directories, or the <num>th directory"
        echo "    -n <num>     Set the current directory to the <num>th item in the list"
        echo "    directory    set the initial item to the specified directory"
        echo "    -w [number]: Print the current marco directories, or the [number]th item"
        echo "    --help -h: print this help"
        ;;
    "-w")
        if [ -z "$MARCODIR" ]; then
            echo "marco: no marco directory set"
        else
            if [ -z $2 ]; then
                echo -n "marco: "
                for i in "${MARCODIR[@]}"; do
                    echo -n "$i "
                done
                echo -e "\n"
            else
                echo "marco: ${MARCODIR[$2 - 1]}"
            fi
        fi
        ;;
    "-n")
        if [ -z "$2" ]; then
            echo "no argument given. use -h for help"
        else
            if [ "$2" -lt 1000 ]; then
                MARCODIR[$2 - 1]="$(pwd)"
            else
                echo "must be between 1 and 1000"
            fi
        fi
        ;;
    *)

        if [ -z "$1" ]; then
            # if no arguments are provided, set the first value of MARCODIR to `pwd`
            MARCODIR[0]=$(pwd)
        else
            if [ -d "$1" ]; then
                MARCODIR[0]=$1
            else
                if [ $1 -lt 1000 ]; then
                    MARCODIR[$1 - 1]=$(pwd)
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
        echo "polo [num] [directory] [-h --help] [-w [num]] "
        echo "    -h --help    Show this help message and exit"
        echo "    [num]        cd to the specified number"
        echo "    -w [num]     Show the list of marco directories, or the <num>th directory"

        ;;
    "-w")
        if [ -z "$MARCODIR" ]; then
            echo "polo: no marco directory set"
        else
            if [ -z $2 ]; then
                echo -n "polo: "
                for i in "${MARCODIR[@]}"; do
                    echo -n "$i "
                done
                echo -e "\n"
            else
                echo "polo: ${MARCODIR[$2 - 1]}"
            fi
        fi
        ;;
    *)
        if [ -z "$1" ]; then
            # if no arguments are provided, move to the first value of MARCODIR
            cd "${MARCODIR[0]}"
        else
            if [ -d "$1" ]; then
                cd "$1"
            else
                if [ $1 -lt 100 ]; then
                    cd "${MARCODIR[$1 - 1]}"
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
                eval "curl http://wttr.in/$1" | less
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

server() {
    local port="${1:-8000}"
    sleep 1 && open "http://localhost:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Create a data URL from a file
dataurl() {
    local mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

server() {
    local port="${1:-8000}"
    sleep 1 && open "http://localhost:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
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
