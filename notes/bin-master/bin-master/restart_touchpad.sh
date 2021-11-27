#!/usr/bin/env bash
# Thanks to https://askubuntu.com/a/721045/

echo -e "${blue}Restarting the 'psmouse' driver...${reset}"
echo -e "${red}Please enter your 'sudo' password...${reset}"

echo sudo modprobe -r psmouse
sudo modprobe -r psmouse
echo sudo modprobe psmouse
sudo modprobe psmouse

echo -e "${green}The 'psmouse' driver was restarted!${reset}"
