#!/bin/sh

if [ -z "$1" ] && [ -z "$2" ] && [ -z "$3" ]; then
    echo "$0: Error. You must pass 3 arguments. 1: order code, 2: pruduct name, 3: new changes." > /dev/stderr
    exit 1
fi

read -r mail < mailto

{
    printf "Subject: O status de entrega de sua encomenda foi atualizado.\n\n";
    printf "O status de entrega da encomenda %s - \"%s\" foi atualizada.\n" "$1" "$2";
    printf "Abaixo, segue a alteração:\n";
    printf "%s\n" "$3";
} | msmtp -a default "$mail"
