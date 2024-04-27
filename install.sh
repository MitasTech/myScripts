#!/bin/bash


echo -ne "
-------------------------------------------------------------------------
   █████╗ ██████╗  ██████╗██╗  ██╗    ███╗   ███╗██╗████████╗ █████╗ ███████╗
  ██╔══██╗██╔══██╗██╔════╝██║  ██║    ████╗ ████║██║╚══██╔══╝██╔══██╗██╔════╝
  ███████║██████╔╝██║     ███████║    ██╔████╔██║██║   ██║   ███████║███████╗
  ██╔══██║██╔══██╗██║     ██╔══██║    ██║╚██╔╝██║██║   ██║   ██╔══██║╚════██║
  ██║  ██║██║  ██║╚██████╗██║  ██║    ██║ ╚═╝ ██║██║   ██║   ██║  ██║███████║
  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝
-------------------------------------------------------------------------
                    Automated Arch Linux Scripts
                          By Stelios Mitas
-------------------------------------------------------------------------

"
sleep 1

# Specify the directory where the scripts are located
script_dir="Scripts"

# Define the script names
script_0="0-AUR_Install.sh"
script_1="1-WindowManager_Install.sh"

# Prompt the user to select a script
echo "Select a script to run:"
echo "1. $script_0"
echo "2. $script_1"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        script="$script_dir/$script_0"
        ;;
    2)
        script="$script_dir/$script_1"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

if [ -f "$script" ]; then
    echo "Running $script..."
    bash "$script"
else
    echo "Script not found: $script"
fi
