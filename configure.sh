#!/bin/bash

# zsh install
echo ''
echo "Now installing zsh..."
echo ''
sudo apt install zsh -y

# Installing git completion
echo ''
echo "Now installing git and bash-completion..."
sudo apt-get install git bash-completion -y

echo ''
echo "Now configuring git-completion..."
GIT_VERSION=`git --version | awk '{print $3}'`
URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
echo ''
echo "Downloading git-completion for git version: $GIT_VERSION..."
if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
	echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
fi
echo "source $HOME/.git-completion.bash" >> ${ZDOTDIR:-$HOME}/.bashrc

# oh-my-zsh install
echo ''
echo "Now installing oh-my-zsh"
echo ''
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh; exit 0)"

# oh-my-zsh plugin install
echo ''
echo "Now installing oh-my-zsh plugins..."
echo ''
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo "source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# powerlevel9k install
echo ''
echo "Now installing powerlevel9k..."
echo ''
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# vimrc vundle install
echo ''
echo "Now installing vundle..."
echo ''
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Pathogen install
echo ''
echo "Now installing Pathogen..."
echo ''
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Nerdtree for vim install
echo ''
echo "Now installing Nerdtree for Vim..."
echo ''
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# Vim color scheme install
echo ''
echo "Now installing vim wombat color scheme..."
echo ''
git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors/wombat 
mv ~/.vim/colors/wombat/colors/* ~/.vim/colors/

# Midnight commander install
echo ''
echo "Now installing Midnight commander..."
echo ''
sudo apt-get install mc -y

# Bash color scheme
echo ''
echo "Now installing solarized dark WSL color scheme..."
echo ''
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark
mv dircolors.256dark .dircolors

# Pull down personal dotfiles
echo ''
echo "Now pulling down jldeen dotfiles..."
git clone https://github.com/jldeen/dotfiles.git ~/.dotfiles
echo ''
cd $HOME/.dotfiles && echo "switched to .dotfiles dir..."
echo ''
echo "Checking out WSL branch..." && git checkout wsl
echo ''
echo "Now configuring symlinks..." && $HOME/.dotfiles/script/bootstrap

# Setup and configure az cli
echo ''
echo "Now installing az cli..."
curl -L https://aka.ms/InstallAzureCli | bash
exec -l $SHELL

# Set default shell to zsh
echo ''
echo "Now setting default shell..."
chsh -s $(which zsh); exit 0

echo '	Badass WSL terminal installed!'