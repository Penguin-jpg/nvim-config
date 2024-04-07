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
