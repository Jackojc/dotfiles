# dotfiles
An attempt to manage my dotfiles across an axis of multiple machines and multiple distros.

# requirements
```sh
xz   # To unpack nixos tarball
wget/curl
shasum/sha256sum/openssl
```

# nix
- `nix-channel --update` update repos
- `nix-env -u '*'` update packages

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
