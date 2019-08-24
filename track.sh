#!/bin/sh

track_order()
{
    echo "Tracking order $1 - $2..."
    if output=$(sh ./fetch.sh "$1"); then
        if [ -e "$1.bck" ]; then
            echo "$output" > "$1"
            if changes=$(diff "$1.bck" "$1"); then
                echo "There is nothing new."
            else
                cp "$1" "$1.bck"
                echo "Changes detected! Attempting to send an email to $(cat < mailto)..." 
                sh ./sendmail.sh "$1" "$2" "$changes"
            fi
            rm "$1"
        else
            echo "$output" > "$1.bck"
            echo "This is the first time fetching $1, its backup file has been set up."
        fi
    fi
    echo "Done."
}

while read -r line; do
    echo "$line" | {
        read -r code description;
        track_order "$code" "$description"
    }
done < orders
