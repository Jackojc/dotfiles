# .bash_profile

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# We need to use `exec` here so that when labwc exits, we return to a login
# and not just a bare shell. This is critical because if anything crashes it
# gives default access to anyone.
[ "$(tty)" = /dev/tty2 ] && exec labwc-launch
