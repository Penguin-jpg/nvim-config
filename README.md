# nvim-config

My personal Neovim config

## Requirements

- [Neovim](https://github.com/neovim/neovim) 0.11.0

## Installation

- Windows

  ```powershell
  Rename-Item -Path $env:LOCALAPPDATA\nvim -NewName $env:LOCALAPPDATA\nvim.bak
  Rename-Item -Path $env:LOCALAPPDATA\nvim-data -NewName  $env:LOCALAPPDATA\nvim-data.bak
  git clone https://github.com/Penguin-jpg/nvim-config $env:LOCALAPPDATA\nvim
  nvim
  ```

- Unix

  ```shell
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  git clone https://github.com/Penguin-jpg/nvim-config ~/.config/nvim
  nvim
  ```

## Dependency

- apt

  ```shell
  sudo apt install xdg-utils
  ```

- Python

  ```shell
  sudo apt install python3-dev python3-pip python3-venv
  pip install pynvim
  pip install pylatexenc
  pip install pre-commit
  ```

- Node

  ```shell
  npm install -g neovim
  npm install -g tree-sitter-cli
  ```

- Cargo

  ```shell
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup update
  cargo install --locked yazi-fm yazi-cli
  ```

- Optional
  - [ripgrep (for live grep)](https://github.com/BurntSushi/ripgrep)
  - [wezterm](https://wezfurlong.org/wezterm/index.html)
