#!/bin/bash

# Capture the current user without sudo messing things up
U=$(who am i | awk '{print $1}')

# Update aptitude and install zsh
echo -e "\n\r \e[36m--\e[32m Updating Aptitude and installing ZSH... \e[36m--\e[0m"
apt update &> /dev/null
apt install zsh cargo cmake -y &> /dev/null

# Set the user's default shell to ZSH
sudo usermod -s /bin/zsh ${U}

# Clone Prezto
echo -e "\n\r \e[36m--\e[32m Cloning Prezto to HOME directory... \e[36m--\e[0m"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto" &> /dev/null

# Create a temporary script to execute with ZSH instead of BASH
cat > z << EOF
#!/bin/zsh

# Link the Prezto config files
echo "\n\r \e[36m--\e[32m Linking Prezto configuration files \e[36m--\e[0m"
setopt EXTENDED_GLOB
for rcfile in "\$HOME"/.zprezto/runcoms/^README.md(.N); do
  ln -s "\$rcfile" "\$HOME/.\${rcfile:t}" &> /dev/null
done

# Copy my dotfiles to the HOME directory
echo "\n\r \e[36m--\e[32m Copying dotfiles to HOME directory \e[36m--\e[0m"
find \$HOME/dotfiles/configs -type f -print0 | xargs -0 -I file cp -v -p file --target-directory=\$HOME
EOF

# Execute and then remove the temporary script
/bin/zsh z && rm z

# Download Vim Plug
echo -e "\n\r \e[36m--\e[32m Installing Vim-Plug \e[36m--\e[0m"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &> /dev/null
# Install the Vim Plugins from .vimrc
vim -c ":PlugInstall | q | q" &> /dev/null

echo -e "\n\r \e[36m--\e[32m COMPLETE \e[36m--\e[0m\n\r\n\r"
echo -e "\e[32mPlease exit and reconnect to enable the changes.\e[0m\n\r"

# Download some additional utilities
echo -e "\n\r \e[36m--\e[32m Installing ripgrep, bat, and exa \e[36m--\e[0m"
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb &> /dev/null
curl -LO https://github.com/sharkdp/bat/releases/download/v0.10.0/bat-musl_0.10.0_amd64.deb &> /dev/null
sudo dpkg -i ripgrep_0.10.0_amd64.deb &> /dev/null
sudo dpkg -i bat-musl_0.10.0_amd64.deb &> /dev/null
cargo install exa &> /dev/null
rm -f ripgrep_0.10.0_amd64.deb bat-musl_0.10.0_amd64.deb

chown ${U}:${U} ~/ -R
exit
