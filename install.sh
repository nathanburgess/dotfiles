#!/bin/bash

# Update aptitude and install zsh
#sudo apt-get update
#sudo apt-get install zsh -y

# Clone Prezto
#git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

# Create a temporary script to link the Prezto config files
cat > z << EOF
echo "\n\r \e[36m--\e[32m Linking Prezto configuration files \e[36m--\e[0m"
setopt EXTENDED_GLOB
#for rcfile in "\$HOME"/.zprezto/runcoms/^README.md(.N); do
#  ln -s "\$rcfile" "\$HOME/.\${rcfile:t}"
#done
EOF

# Set the user's default shell to ZSH and update
chsh -s /bin/zsh
source $HOME/.zshrc

# Execute and then remove the temporary script
/bin/zsh z && rm z

# Copy custom config files over defaults
echo "\n\r \e[36m--\e[32m Copying configuration files to HOME directory \e[36m--\e0m"
find configs -type f -print0 | xargs -0 -I file cp -v -p file --target-directory=$HOME
 
# Download Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install some Vim plugins
vim -c ":PlugInstall | q | q"
