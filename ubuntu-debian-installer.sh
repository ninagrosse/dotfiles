#!/bin/bash

LOCAL_DIR="$HOME/.local/bin"
mkdir -p "$LOCAL_DIR"

# Packages with apt installation
sudo apt update && sudo apt install gpg -y

sudo add-apt-repository ppa:zhangsongcui3371/fastfetch

sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list # eza
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

curl -SsL https://packages.httpie.io/deb/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/httpie.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/httpie.gpg] https://packages.httpie.io/deb ./" | sudo tee /etc/apt/sources.list.d/httpie.list >/dev/null

sudo apt update && sudo apt install bat btop direnv eza fastfetch fd-find fzf httpie jq neovim ugrep unzip -y

# symlink for bat and cat which are named batcat and fdfind on Debian/Ubuntu
ln -s $(which batcat) "$LOCAL_DIR"/bat
ln -s $(which fdfind) "$LOCAL_DIR"/fd

# Packages with manual installation
ATUIN_UNMANAGED_INSTALL=1 curl --proto '=https' --tlsv1.2 -LsSf https://github.com/atuinsh/atuin/releases/latest/download/atuin-installer.sh | sh
# add to .zshrc: source "$HOME/.atuin/bin/env"

wget -q -O "$LOCAL_DIR"/dysk https://dystroy.org/dysk/download/aarch64-unknown-linux-gnu/dysk

curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | grep "amd64.deb" | xargs -n 1 curl -LJO
sudo dpkg -i git-delta_*amd64.deb
rm *.deb

curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install -Dm 755 lazygit -t "$LOCAL_DIR"
rm lazygit lazygit.tar.gz

curl -s https://api.github.com/repos/mike-engel/jwt-cli/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | grep "jwt-linux.tar.gz" | xargs -n 1 curl -LJO
tar xf jwt-linux.tar.gz jwt
install -Dm 755 jwt -t "$LOCAL_DIR"
rm jwt-linux.tar.gz jwt

curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | grep "amd64.deb" | xargs -n 1 curl -LJO
sudo dpkg -i ripgrep_*amd64.deb
rm ripgrep*

curl -sS https://starship.rs/install.sh | sh

curl -s -o tldr https://api.github.com/repos/tealdeer-rs/tealdeer/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | grep "tealdeer-linux-aarch64-musl" | xargs -n 1 curl -LJO
install -Dm 755 tldr -t "$LOCAL_DIR"
rm tldr

curl -s https://api.github.com/repos/sxyazi/yazi/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | grep "x86_64-unknown-linux-musl" | xargs -n 1 curl -LJO
unzip -j yazi-*.zip yazi-x86_64-unknown-linux-musl/ya yazi-x86_64-unknown-linux-musl/yazi
install -Dm 755 yazi -t "$LOCAL_DIR"
install -Dm 755 ya -t "$LOCAL_DIR"
rm yazi-*.zip yazi ya

curl -s https://api.github.com/repos/ajeetdsouza/zoxide/releases/latest | grep "browser_download_url" | cut -d '"' -f 4 | grep "x86_64-unknown-linux-musl" | xargs -n 1 curl -LJO
tar -xf zoxide-*.tar.gz zoxide
install -Dm 755 zoxide -t "$LOCAL_DIR"
rm zoxide-*.tar.gz
