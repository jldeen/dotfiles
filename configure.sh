#!/bin/bash

# zsh install
echo "Now installing zsh..."
sudo apt install zsh -y

# oh-my-zsh install
echo "Now installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh plugin install
echo "Now installing oh-my-zsh..."
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo "source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# powerlevel9k install
echo "Now installing powerlevel9k..."
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# vimrc vundle install
echo "Now installing vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Pathogen install
echo "Now installing Pathogen..."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Nerdtree for vim install
echo "Now installing Nerdtree for Vim..."
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# Vim color scheme install
echo "Now installing vim wombat color scheme..."
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors/wombat 
mv ~/.vim/colors/wombat/colors/* ~/.vim/colors/

# Midnight commander install
echo "Now installing Midnight commander..."
sudo apt-get install mc -y

# Bash color scheme
echo "Now installing solarized dark WSL color scheme..."
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
mv dircolors.256dark .dircolors

# Pull down personal dotfiles
echo "Now pulling down jldeen dotfiles and configuring symlinks..."
git clone https://github.com/jldeen/dotfiles.git ~/.dotfiles
cd $HOME/.dotfiles
git checkout wsl
source script/bootstrap

# Set default shell to zsh
echo "Now setting default shell..."
chsh -s $(which zsh); exit 0

