#!/bin/bash

# Set the user's default shell to ZSH
chsh -s /bin/zsh

# Create a temporary script to execute with ZSH instead of BASH
cat > z << EOF
#!/bin/zsh

# Update aptitude and install zsh

echo "\n\r \e[36m--\e[32m Updating Aptitude and installing ZSH... \e[36m--\e[0m"
sudo apt-get update &> /dev/null
sudo apt-get install zsh -y &> /dev/null

echo "\n\r \e[36m--\e[32m Cloning Prezto to HOME directory... \e[36m--\e[0m"

# Clone Prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "\$HOME/.zprezto" &> /dev/null

echo "\n\r \e[36m--\e[32m Linking Prezto configuration files \e[36m--\e[0m"

setopt EXTENDED_GLOB
for rcfile in "\$HOME"/.zprezto/runcoms/^README.md(.N); do
  ln -s "\$rcfile" "\$HOME/.\${rcfile:t}" &> /dev/null
done

echo "\n\r \e[36m--\e[32m Copying dotfiles to HOME directory \e[36m--\e[0m"
find configs -type f -print0 | xargs -0 -I file cp -v -p file --target-directory=\$HOME

# Download Vim Plug
echo "\n\r \e[36m--\e[32m Installing Vim-Plug \e[36m--\e[0m"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &> /dev/null
# Install some Vim plugins
vim -c ":PlugInstall | q | q" 
EOF

# Execute and then remove the temporary script
#/bin/zsh z && rm z

