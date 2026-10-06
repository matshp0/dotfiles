# dotfiles

Personal config for Omarchy (Hyprland). Only custom files; Omarchy defaults are not included.
Layout mirrors `$HOME`, so it works with `stow`.

- `.config/hypr` - bindings, input, looknfeel, monitors (Lua)
- `.config/nvim` - LazyVim setup
- `.config/tmux/tmux.conf`, `.tmux.reset.conf` - tmux (plugins installed via tpm)

```sh
git clone https://github.com/matshp0/dotfiles ~/dotfiles
cd ~/dotfiles && stow -t ~ .
```
