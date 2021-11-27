#/bin/sh

# A tool to lock properly a tty console
#  and do some other nice stuffs

#  Feel free to completely custom the messages !
#  Also the path used for -i option in notify-send

notify-send -i "$HOME/.link.ico" "Locked" "The current terminal has been locked by $USER."

cmatrix -b -f -s -u 9

clear

# Uses the value of $VLOCK_CURRENT_MESSAGE, for the message after been unlocked, if defined : feel free to define it
#  in your ~/.bashrc or ~/.bash_aliases for example.
vlock --current

notify-send -i "$HOME/.link.ico" "Unlocked" "The current terminal has been unlocked by $USER."

clear

echo -e "${green} User ${blue}$USER${green} is back online !${white}"

# A script by Naereen Corp.
#  https://sites.google.com/site/naereencorp/
