#!/bin/bash

# Check if the user is root
#if [ "$(id -u)" -ne 0 ]; then
#    echo "Please run this script as root"
#    exit 1
#fi
echo -ne "
                         █████╗ ██████╗  ██████╗██╗  ██╗    ███╗   ███╗██╗████████╗ █████╗ ███████╗                                    
                        ██╔══██╗██╔══██╗██╔════╝██║  ██║    ████╗ ████║██║╚══██╔══╝██╔══██╗██╔════╝                                    
                        ███████║██████╔╝██║     ███████║    ██╔████╔██║██║   ██║   ███████║███████╗                                    
                        ██╔══██║██╔══██╗██║     ██╔══██║    ██║╚██╔╝██║██║   ██║   ██╔══██║╚════██║                                    
                        ██║  ██║██║  ██║╚██████╗██║  ██║    ██║ ╚═╝ ██║██║   ██║   ██║  ██║███████║                                    
                        ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝                                    
                                                                                                                                       
 █████╗ ██╗   ██╗██████╗     ██╗  ██╗███████╗██╗     ██████╗ ███████╗██████╗     ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
██╔══██╗██║   ██║██╔══██╗    ██║  ██║██╔════╝██║     ██╔══██╗██╔════╝██╔══██╗    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
███████║██║   ██║██████╔╝    ███████║█████╗  ██║     ██████╔╝█████╗  ██████╔╝    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
██╔══██║██║   ██║██╔══██╗    ██╔══██║██╔══╝  ██║     ██╔═══╝ ██╔══╝  ██╔══██╗    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
██║  ██║╚██████╔╝██║  ██║    ██║  ██║███████╗███████╗██║     ███████╗██║  ██║    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝
--------------------------------------------------------------------------------------------------------
"
sleep 1
echo "-------Install dependencies if needed-------"
sleep 2
# Install dependencies if needed
pacman -Sy --needed --noconfirm base-devel git

# Prompt user for AUR helper choice
echo "Choose an AUR helper to install:"
echo "1. yay"
echo "2. paru"
echo "3. pakku"
echo "4. pacaur"
echo "5. trizen"
echo "6. aura"
echo "7. pikaur"

read -p "Enter your choice (1-7): " choice

case $choice in
    1)
        aur_helper="yay"
        url="https://aur.archlinux.org/yay.git"
        ;;
    2)
        aur_helper="paru"
        url="https://aur.archlinux.org/paru.git"
        ;;
    3)
        aur_helper="pakku"
        url="https://aur.archlinux.org/pakku.git"
        ;;
    4)
        aur_helper="pacaur"
        url="https://aur.archlinux.org/pacaur.git"
        ;;
    5)
        aur_helper="trizen"
        url="https://aur.archlinux.org/trizen.git"
        ;;
    6)
        aur_helper="aura"
        url="https://aur.archlinux.org/aura.git"
        ;;
    7)
        aur_helper="pikaur"
        url="https://aur.archlinux.org/pikaur.git"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

# Clone the AUR helper repository
cd /tmp
git clone $url
cd $aur_helper

# Build and install the AUR helper
makepkg -si --noconfirm

# Clean up
cd ..
rm -rf $aur_helper

echo "Installation of $aur_helper completed."
