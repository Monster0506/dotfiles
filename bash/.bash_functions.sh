#! /usr/bin/env bash
# some useful functions and aliases
md(){
  pandoc -t plain "${1:-README.md}" | lynx -stdin
}
clock(){
    # display a fancy clock using figlet

    # get the current time
    time=$(date +"%r")
    # create the clock with a border around it
    figlet -f big -w 80 -c "$time"

}
me(){
echo -e "

$red███╗░░░███╗░█████╗░███╗░░██╗░██████╗████████╗███████╗██████╗░░█████╗░███████╗░█████╗░░█████╗░
████╗░████║██╔══██╗████╗░██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔═══╝░
$coldblue██╔████╔██║██║░░██║██╔██╗██║╚█████╗░░░░██║░░░█████╗░░██████╔╝██║░░██║██████╗░██║░░██║██████╗░
██║╚██╔╝██║██║░░██║██║╚████║░╚═══██╗░░░██║░░░██╔══╝░░██╔══██╗██║░░██║╚════██╗██║░░██║██╔══██╗
$smoothgreen██║░╚═╝░██║╚█████╔╝██║░╚███║██████╔╝░░░██║░░░███████╗██║░░██║╚█████╔╝██████╔╝╚█████╔╝╚█████╔╝
╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝░╚════╝░╚═════╝░░╚════╝░░╚════╝░
"

}
whatTime(){
	Year=`date +%Y`
	Month=`date +%m`
	Day=`date +%d`
	Hour=`date +%H`
	Minute=`date +%M`
	Second=`date +%S`
# echo `date`
figlet -f big -w 80 -c "$Day-$Month-$Year"
clock
}
function up()
{
    for i in `seq 1 $1`;
     do
        cd ../
    done;
}

randomname() {
    for FILE in "$@"; do
        BASE="${FILE%.*}"
        EXT="${FILE#$BASE}"
        EXT="${EXT#.}"  # correctly deal with names without extensions

        # retry arbitrarily many times on (unlikely) collision
        while true; do
            NEW_BASE="$RANDOM$RANDOM$RANDOM"  # 32767^3 (ish) possibilities
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
# Bash Function To Extract File Archives Of Various Types

extract (){
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar) unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip) unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace) unace x ./"$n"      ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)       arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
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
marco(){
    case $1 in
        "-h" | "--help" )
            echo "marco [-w]"
            echo "     set the marco directory to the current directory"
            echo "    -w:        print current marco directory"
            echo "    --help -h: print this help"
        ;;
        "-w")
            echo "$curDir"
        ;;
        *)
            if [ -z "$1" ]; then
                curDir=$(pwd)
                echo "$curDir"
            else
                if [ -d "$1" ]; then
                    curDir="$1"
                    echo "$curDir"
                else
                    echo "marco: $1: No such file or directory"
                fi
            fi
        ;;
    esac
}

polo(){
    case $1 in
        "-h" | "--help" )
            echo "polo [-w]"
            echo "     move to the current marco directory"
            echo "     this can be used with marco to set the marco directory"
            echo "    -w:        print current marco directory"
            echo "    --help -h: print this help"
        ;;
        "-w")
            echo "$curDir"
        ;;
        *)
            if [ -z "$1" ]; then
                cd "$curDir"
            else
                if [ -d "$1" ]; then
                    cd "$1"
                else
                    echo "polo: $1: No such directory"
                fi
            fi
        ;;
    esac
}


zipExt(){
    if [ -z "$2" ] || [ -z "$1" ]; then
        return 1
    fi
    find . | egrep "\.($1)$" | zip -@ "$2".zip
}

findInFiles(){
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
