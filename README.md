# Track my orders
This set of scripts are useful for tracking any orders from Correios delivery service.

# Dependencies
You will need to have installed `curl` for fetching information from Correios' website, and `msmtp` for sending email.

# Setup
Once you cloned this repository, to track your orders, you'll need to create a file called `orders` and then store your orders in it as follows:
```sh
PxxxxxxxxxxBR Laptop that I just bought hehe
...           ...
```
The first word *needs* to be the Correios code, and the rest is optional but you might put the title or description of your order.

Also, you might to create a file called `mailto`, and put the email address you want to keep notifying after any change is detected in your orders.

> You will need to setup `msmtp` in order to send mails.

# Usage
In your terminal, you just need to run the following command to get an update of your orders.
```sh
sh ./track.sh
```
It will read your `orders` file and track the orders one by one.

At the very first time you track an order, it will keep a backup file to be using to compare to any new changes.

In case of a change is detected, it will try to send an email to the referred email in `mailto` file. This is totally optional once you can just change the script to be notified the way you prefer. For instance, get notified by `notify-send` command.

# Tips
You might want to keep it running in the background without explicitly run it. In this case, you just need to create some script like:
```sh
#!/bin/sh
while true; do
    sh ./track.sh
    sleep 3600
done;

# trackd.sh
```

and then execute it in the background:
```sh
sh ./trackd.sh >> /dev/null &
```

This script will simply run `track.sh` once an hour as soon as it is executed.
