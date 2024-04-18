#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi
echo -ne "


                                             █████╗ ██████╗  ██████╗██╗  ██╗    ███╗   ███╗██╗████████╗ █████╗ ███████╗                                                       
                                            ██╔══██╗██╔══██╗██╔════╝██║  ██║    ████╗ ████║██║╚══██╔══╝██╔══██╗██╔════╝                                                       
                                            ███████║██████╔╝██║     ███████║    ██╔████╔██║██║   ██║   ███████║███████╗                                                       
                                            ██╔══██║██╔══██╗██║     ██╔══██║    ██║╚██╔╝██║██║   ██║   ██╔══██║╚════██║                                                       
                                            ██║  ██║██║  ██║╚██████╗██║  ██║    ██║ ╚═╝ ██║██║   ██║   ██║  ██║███████║                                                       
                                            ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝                                                       
                                                                                                                                                                              
██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗     ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║    ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║    ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝    ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝     ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                           Automated Installation of Window Managers
                                                                      by Stelios Mitas
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


"
sleep 1

AUR_HELPER=("yay" "paru" "pakku" "paccaur" "trizen" "aura" "pikaur")

# Function to install packages from both official repositories and AUR
install_packages() {
  local wm_choice="$1"
  local official_pkg_file=""
  local aur_pkg_file=""

  case "$wm_choice" in
    1) official_pkg_file="1-WindowManager-Install/Pacman_Packages/qtile_official_packages.txt"
       aur_pkg_file="1-WindowManager-Install/AUR_Packages/qtile_aur_packages.txt" ;;
    2) official_pkg_file="1-WindowManager-Install/Pacman_Packages/hyprland_official_packages.txt"
       aur_pkg_file="1-WindowManager-Install/AUR_Packages/hyprland_aur_packages.txt" ;;
    3) official_pkg_file="1-WindowManager-Install/Pacman_Packages/xmonad_official_packages.txt"
       aur_pkg_file="1-WindowManager-Install/AUR_Packages/xmonad_aur_packages.txt" ;;
    4) official_pkg_file="1-WindowManager-Install/Pacman_Packages/bspwm_official_packages.txt"
       aur_pkg_file="1-WindowManager-Install/AUR_Packages/bspwm_aur_packages.txt" ;;
    *)
      echo "Invalid choice. Exiting."
      exit 1
      ;;
  esac

  if [ ! -f "$official_pkg_file" ]; then
    echo "Official package file '$official_pkg_file' not found."
    exit 1
  fi

  if [ ! -f "$aur_pkg_file" ]; then
    echo "AUR package file '$aur_pkg_file' not found."
    exit 1
  fi

  echo "Installing official packages for the selected window manager..."
  sudo pacman -S --needed - < "$official_pkg_file" || { echo "Official package installation failed."; exit 1; }

  echo "Installing AUR packages for the selected window manager..."
  $AUR_HELPER -S --needed - < "$aur_pkg_file" || { echo "AUR package installation failed."; exit 1; }
}

# Prompt the user for their window manager choice
echo "Select your window manager:"
echo "1. Qtile"
echo "2. Hyprland"
echo "3. XMonad"
echo "4. BSPWM"
read -p "Enter your choice (1/2/3/4): " wm_choice

# Validate user input
if ! [[ "$wm_choice" =~ ^[1-4]$ ]]; then
  echo "Invalid choice. Exiting."
  exit 1
fi

# Install packages based on user's choice
install_packages "$wm_choice"
