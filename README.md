# nvim-config

My personal neovim config

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

- Python

  ```shell
  sudo apt-get install python3-dev python3-pip python3-venv
  pip install pynvim
  ```

- Node

  ```shell
  npm install -g neovim
  ```

- Optional
  - [ripgrep (for live grep)](https://github.com/BurntSushi/ripgrep)
