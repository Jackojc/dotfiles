# dotfiles
An attempt to manage my dotfiles across an axis of multiple machines and multiple distros.

# requirements
```sh
xz   # To unpack nixos tarball
wget/curl
shasum/sha256sum/openssl
```

# nix
```sh
$ nix-channel --update    # Update repos
$ nix-env -u '*'          # Update packages
```

# void
Installing proprietary packages:
```sh
$ git clone https://github.com/void-linux/void-packages packages --depth 1 --recursive
$ cd packages
$ echo XBPS_ALLOW_RESTRICTED=yes >> etc/conf
$ ./xbps-src binary-bootstrap
$ ./xbps-src clean
$ ./xbps-src pkg -f <pkg>
$ ./xbps-src install <pkg>
$ sudo xbps-install --repository=hostdir/binpkgs/nonfree <pkg>
```

# tmux
Tmux usually has fucked up colours unless you compile the tmux-256color
terminfo file in `~/.local/share/terminfo/t/tmux-256color.terminfo` using
`tic <file>`.

# local config
### git
Setup system local configuration in `~/.gitconfig-local` such as
user credentials or proxy configs on corporate networks.

### ssh (with git)
> Make sure to add public key to GitHub to allow pushing/pulling etc.
```sh
$ ssh-keygen -t ed25519 -C "me@mail.com"
$ eval "$(ssh-agent -s)"      # Optionally add to ssh-agent or just add to ssh config.
$ ssh-add ~/.ssh/id_ed25519
```

### bash
There is a file `~/.bashrc-local` for setting up system local
settings and variables.

### untrack local configs
It is probably best to untrack these files after making local
alterations.

```sh
$ git update-index --skip-worktree .gitconfig-local   # From project root
$ git update-index --skip-worktree .bashrc-local 
```

# gpg
Fix permissions of GPG directory:
```sh
$ chown -R $(whoami) ~/.gnupg/
$ find ~/.gnupg -type f -exec chmod 600 {} \;
$ find ~/.gnupg -type d -exec chmod 700 {} \;
```
