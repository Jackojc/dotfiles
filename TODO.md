# TODO
- Prompt before installing nix or list of packages
- Namespaced scripts (generic wrapper for bemenu that opens with pre-filter for i.e. power related scripts)
- Use generic name for launching wayland
- Use a river tiling script
- Fix issue with bemenu where left side has opaque background (open bemenu on bright background)
- Find better status bar
- Screenshot aliases for slurp and grim
- Maybe switch XDG_DESKTOP vars to sway instead of river, might improve compatibility
- Prompt on exit application
- Allow foot to open in CWD from previous instance (OSC 7)
- On-screen display for volume/brightness etc.
- Status bar should remain visible while in an alternate keybinding group and then automatically hide when returning to normal mode

### System
- Deduplicate root volume
- runit user services

### Dotfiles
- Add useful notes directory to dotfiles repo (system management, volumes/lvm2 etc etc)
- Split configs/bin into shell and desktop components
- Dependency checks for scripts
- Cleanup unused dotfiles
- Generate list of xbps packages and add script to install them
- Yambar/Sfwbar

### Labwc
- Volume/Brightness notifications
- Display control and brightness (DDC/CI?)
- Pipe menus for various utils to replace dmenu prompts
- Screenshot keybinds

### General
- Switch to keepassxc (supports cli aswell)
