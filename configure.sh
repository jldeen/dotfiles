#!/bin/bash
# oh-my-zsh install
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# oh-my-zsh plugin install

git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# powerlevel9k install
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# vimrc vundle install

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Pathogen install
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Nerdtree for vim install
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# Vim color scheme install
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors/wombat 
mv ~/.vim/colors/wombat/colors/* ~/.vim/colors/

# Midnight commander install
sudo apt-get install mc -y

# Bash color scheme
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
mv dircolors.256dark .dircolors

# Pull down personal dotfiles
git clone https://github.com/jldeen/dotfiles.git ~/.dotfiles
cd .dotfiles
source script/bootstrap

# Set default shell to zsh
chsh -s $(which zsh); exit

#### WSL Terminal Emulator configuration below

# Install 7z

# Install WSL Terminal
#bash -c "wget https://github.com/goreliu/wsl-terminal/releases/download/v0.8.3/wsl-terminal-0.8.3.7z && 7z x wsl-terminal-0.8.3.7z"

