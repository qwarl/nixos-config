# Users Module

## Current State
This directory currently contains packages installed for the current user. Users are named according to their Desktop Environment/Window Manager (DE/WM) to easily distinguish which packages are needed for each environment. The `quan` user exists because it was created during VM testing before this naming convention was established.

## Architecture Plan
The goal is to refactor the package management structure:

1. **Separate packages from users**: Move package definitions to their respective DE/WM directories (directories for KDE and Hyprland already exist)
2. **Users as importers**: The users directory should only import packages and configurations to create a complete, ready-to-use DE/WM setup
3. **Minimal user.nix**: Individual user.nix files should only contain additional packages needed during regular usage

## File Structure
- `hyprland.nix`: User configuration for Hyprland environment
- `kde.nix`: User configuration for KDE environment  
- `quan.nix`: Legacy user configuration (from VM testing period)
