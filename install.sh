#!/bin/bash
RED="\e[31m" BLUE="\e[34m" RESET="\e[0m" GREEN="\e[32m"
echo -e "${BLUE}---------------------------------------"
echo -e "Persona 3 Reload shell theme installer"
echo -e "---------------------------------------${RESET}"
echo ""
echo "Welcome to the P3 theme installer. Type a number to select a theme to be installed:"
echo "Type Ctrl+C to cancel the installation"
echo ""
echo "1) Makoto Yuki/Minato Arisato"
echo "2) Junpei Iori"
echo "3) Yukari Takeba"
echo "4) Mitsuru Kirijo"
echo "5) Akihiko Sanada"
echo "6) Shinjiro Aragaki"
echo "7) Koromaru"
echo "8) Ken Amada"
echo "9) Aigis"
echo "10) Aigis (DLC version)"
echo "11) Metis (DLC)"
echo ""

read -p "Type in number: " number

# Check selection
if [[ "$number" == "1" ]]; then
    name="yuki"
elif [[ "$number" == "2" ]]; then
    name="iori"
elif [[ "$number" == "3" ]]; then
    name="takeba"
elif [[ "$number" == "4" ]]; then
    name="kirijo"
elif [[ "$number" == "5" ]]; then
    name="sanada"
elif [[ "$number" == "6" ]]; then
    name="aragaki"
elif [[ "$number" == "7" ]]; then
    name="koromaru"
elif [[ "$number" == "8" ]]; then
    name="amada"
elif [[ "$number" == "9" ]]; then
    name="aigis"
elif [[ "$number" == "10" ]]; then
    name="aigis-dlc"
elif [[ "$number" == "11" ]]; then
    name="metis"
else
    echo -e "${RED}Invalid selection. Exiting.${RESET}"
    exit 1
fi

# Check folders
if [[ ! -d "$name" ]]; then
    echo -e "${RED}Error: Theme folder '$name' not found!${RESET}"
    exit 1
fi

# Copy
sudo cp -r "$name" /boot/grub/themes/

# Set GRUB theme
sudo sed -i "s|^GRUB_THEME.*|GRUB_THEME=/boot/grub/themes/${name}/theme.txt|" /etc/default/grub
sudo sed -i "s|^#GRUB_THEME.*|GRUB_THEME=/boot/grub/themes/${name}/theme.txt|" /etc/default/grub

# Update GRUB
if command -v pacman >/dev/null; then
    sudo grub-mkconfig -o /boot/grub/grub.cfg
else
    sudo update-grub
fi

echo -e "${GREEN}Installation completed successfully."
echo -e "Would you like to reboot?${RESET}"
read -p "[0) No 1) Yes]: " rebootnum
if [[ "$rebootnum" == "1" ]]; then
    reboot
else
    exit
fi
