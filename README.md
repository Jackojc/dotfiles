# dotfiles
An attempt to manage my dotfiles across an axis of
multiple machines and multiple distros.

# new machine setup
```sh
$ ./xbps.sh
$ ./mkdirs.sh
$ ./firefox.sh
$ ./stow.sh
$ git config core.hooksPath hooks
```

- `xbps.sh` requires root perms
- `mkdirs.sh` create XDG directories
- `firefox.sh` create default profile for user prefs
- `core.hooksPath` install lint.sh hook in git for shellcheck

# grammars/syntax highlighting
Treesitter grammars for custom languages in helix:
```
shell/.config/helix/grammars/<name>/          grammar.js, tree-sitter.json
shell/.config/helix/runtime/queries/<name>/   highlights.scm
shell/.config/helix/languages.toml            lsp config
```

Generate and build grammars:
```sh
$ for lang in ~/.config/helix/grammars/*/; do (cd "$lang" && tree-sitter generate --abi 15); done
$ hx --grammar build
```

# handbook
Win+Shift+? to run `tool-handbook`. Opens the handbook
(`common/.local/share/handbook/handbook.typ`) in helix with
the PDF viewer for live editing or reading.

# void
Proprietary packages:
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

### untrack local configs
It is probably best to untrack this file after making local
alterations.

```sh
$ git update-index --skip-worktree common/.gitconfig-local   # From project root
```

# gpg
Fix permissions of GPG directory:
```sh
$ chown -R $(whoami) "${XDG_DATA_HOME}/gnupg/"
$ find "${XDG_DATA_HOME}/gnupg" -type f -exec chmod 600 {} \;
$ find "${XDG_DATA_HOME}/gnupg" -type d -exec chmod 700 {} \;
```
