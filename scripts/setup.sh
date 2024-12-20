#! /bin/bash

# NixOS Unstable Channel

    echo "Switching to NixOS Unstable Channel..."

    # Add NixOS Unstable Channel
    sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos

    # Update Channels
    sudo nix-channel --update

    # Rebuild & Upgrade
    sudo nixos-rebuild switch --upgrade

# Home Manager Standalone

    echo "Installing Home Manager Standalone..."

    # Add Home Manager Channel
    sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

    # Update Channels
    sudo nix-channel --update

    # Install Home Manager
    nix-shell '<home-manager>' -A install

# Install Plasma Manager - Needs Testing

    #    echo "Installing Plasma Manager..."
    #
    #    # Add Plasma Manager Channel
    #    sudo nix-channel --add https://github.com/nix-community/plasma-manager/archive/trunk.tar.gz plasma-manager
    #
    #    # Update Channels
    #    sudo nix-channel --update plasma-manager
    #
    #    # Install Home Manager
    #    nix-shell '<plasma-manager>' -A install

# Initial Dotfiles Creation - Needs If/Then Check

    # Create Dotfiles Folder in HOME

    #    mkdir -p $HOME/.dotfiles

    #    # NixOS Configuration Files
    
    #    echo "Moving NixOS Configuration Files..."

    #    sudo mv /etc/nixos/configuration.nix $HOME/.dotfiles/nixos/
    #    sudo mv /etc/nixos/hardware-configuration.nix $HOME/.dotfiles/nixos/

    #    # NixOS Home Manager Configuration Files
    #    echo "Moving Home Manager Configuration Files..."

    #    mv $HOME/.config/home-manager/home.nix $HOME/.dotfiles/nixos/
    #    mv $HOME/.config/home-manager/flake.nix $HOME/.dotfiles/nixos/
    #    mv $HOME/.config/home-manager/flake.lock $HOME/.dotfiles/nixos/

# Download Dotfiles from Github - Done Manually
    #    # Create Temporary Shell Using Git
    #    nix-shell -p git neovim
    #    # Ensure Home Directory
    #    cd $HOME
    #    # Clone Dotfiles Repository
    #    git clone https://github.com/machtendo/dotfiles.git
    #    # Exit nix-shell
    #    exit
    #    # Ensure Home Directory
    #    cd $HOME
    #    # Hide Dotfiles Folder
    #    mv $HOME/dotfiles $HOME/.dotfiles

# Link Dotfiles

    # Create Links - NixOS Configuration Files
    
    echo "Setting NixOS Soft Links..."
    sudo ln -sf $HOME/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix

    # Move & Link hardware-configuration.nix
    
    sudo mv /etc/nixos/hardware-configuration.nix $HOME/.dotfiles/nixos/hardware-configuration.nix
    sudo ln -sf $HOME/.dotfiles/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

    # NixOS Home Manager Configuration Files
    
    echo "Setting Home Manager Soft Links..."

    ln -sf $HOME/.dotfiles/nixos/home.nix $HOME/.config/home-manager/home.nix
    ln -sf $HOME/.dotfiles/nixos/flake.nix $HOME/.config/home-manager/flake.nix
    ln -sf $HOME/.dotfiles/nixos/flake.lock $HOME/.config/home-manager/flake.lock

# NixOS Upgrade & Rebuild

    echo "Final NixOS Rebuild..."

    sudo nixos-rebuild switch --upgrade

# End

    echo "Your device is configured. Reboot Recommended."
