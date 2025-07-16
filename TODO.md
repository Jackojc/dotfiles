# TODO
- Prompt before installing nix or list of packages
- Namespaced scripts (generic wrapper for bemenu that opens with pre-filter for i.e. power related scripts)
- Fix issue with bemenu where left side has opaque background (open bemenu on bright background)
- Find better status bar
- Screenshot aliases for slurp and grim
- Prompt on exit application
- Allow foot to open in CWD from previous instance (OSC 7)
- On-screen display for volume/brightness etc.
- Status bar should remain visible while in an alternate keybinding group and then automatically hide when returning to normal mode

### System
- Deduplicate root volume
- runit user services
- create wl-launch script that takes compositor as argument

### Dotfiles
- Add useful notes directory to dotfiles repo (system management, volumes/lvm2 etc etc)
- Split configs/bin into shell and desktop components
- Dependency checks for scripts
- Cleanup unused dotfiles
- Generate list of xbps packages and add script to install them
- Yambar/Sfwbar

### Labwc
- Volume/Brightness notifications
- Pipe menus for various utils to replace dmenu prompts
- Run or raise/scratchpads. see if it's possible to have dropdown terminals

### General
- Switch to keepassxc (supports cli aswell)


### Unsorted
- pipe menus
- how to authenticate to run tasks as root from menu
- menu separators
- menu labels (without function)

- restrict alt-tab to current display if possible
- keybinds to shrink size
- moving window to smaller display makes it go off screen edges (can we set an action to set its size?)
- xfce panel
- keep-running script which checks if something is running and then loops
- vertically/horizontally locked resize with mouse
- fix pass through of w-tab for w-s-tab
- snap-to-edge, can we make it snap to remaining space instead of always 50% (maybe we can also highlight this way too)
- fix snapping to window edge across displays
- mouse scroll resize
