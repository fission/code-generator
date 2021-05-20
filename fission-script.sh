#!/bin/bash
function checkCommand() {
    if ! command -v $1; then
        echo "$1 command missing."
        exit 1
    fi
}

function strReplace() {
    ORIG=$1
    REPL=$2
    for f in $(grep -rH '\$\.type' . | cut -d':' -f1 | grep '\.go$' | sort | uniq); do
        echo $f
        sed -i.bak "s/"$ORIG"/"$REPL"/g" $f
    done
}

function cleanBkpFile() {
    find . -name '*.bak' -exec rm {} \;
}

function checks() {
    checkCommand command
    checkCommand sed
    checkCommand grep
    checkCommand cut
    checkCommand sort
    checkCommand uniq
}

strReplace '\$\.type\|private\$' '\_\$\.type\|private\$'
strReplace '\$\.inputType\|private\$' '\_\$\.inputType\|private\$'
cleanBkpFile
