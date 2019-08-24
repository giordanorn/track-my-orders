#!/bin/sh

if [ -z "$1" ]; then
    echo "$0: Error. You should pass the code as first argument." > /dev/stderr
    exit 1
else
    if raw=$(curl -s "https://www.linkcorreios.com.br/$1" | hxnormalize -x); then
        output=$(echo "$raw" | hxselect "table")
        if [ -z "$output" ]; then
            output=$(echo "$raw" | hxselect "div#conteudo")
            echo "$0: Error. $output" > /dev/stderr
            exit 1
        else
            output=$(echo "$output" | w3m -dump -cols 2000 -T 'text/html')
            echo "$output"
        fi
    else
        echo "$0: Error. Curl has failed to fetch $1." > /dev/stderr
        exit 1
    fi
fi

