# dotfiles
An attempt to manage my dotfiles across an axis of multiple machines and multiple distros.

# local config
### git
Setup system local configuration in `~/.gitconfig-local` such as
user credentials or proxy configs on corporate networks.

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

# requirements
```sh
xz   # To unpack nixos tarball
wget/curl
shasum/sha256sum/openssl
```

# notes
- `nix-channel --update` update repos
- `nix-env -u '*'` update packages
