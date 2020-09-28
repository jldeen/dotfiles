#!/bin/bash
set -eou pipefail

source /dev/stdin <<< "$(curl -fsSL https://raw.githubusercontent.com/jldeen/dotfiles/mac/script/prompt)"

brewInstall () {
    # Install brew
    if test ! $(which brew); then
    # Install the correct homebrew for each OS type
        if test "$(uname)" = "Darwin"
        then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            success 'brew installed'
        elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
        then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
            success 'brew installed'
        fi
    else
        info 'brew is already installed'
    fi
}

brewUpdate () {
    brew update
    success 'brew updated'
}

zshInstall () {
    # zsh install
    # todo add in check for macOS 10.15 since zsh is default
    if test $(which zsh); then
        info "zsh already installed..."
    else
        brew install zsh zsh-completions
        success 'zsh and zsh-completions installed'
    fi
}

zshZInstall () {
    # Install z for dir searching
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-z" ]; then
        info "zsh-z already exists..."
    else
        git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z
        success 'zsh-z installed'
    fi
}

configureGitCompletion () {
    GIT_VERSION=`git --version | awk '{print $3}'`
    URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
    success "git-completion for $GIT_VERSION downloaded"
    if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
        echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
        fail 'git completion download failed'
    fi
}

ohmyzshInstall () {
    # oh-my-zsh install
    if [ -d ~/.oh-my-zsh/ ] ; then
    info 'oh-my-zsh is already installed...'
    read -p "Would you like to update oh-my-zsh now? y/n " -n 1 -r
    echo ''
        if [[ $REPLY =~ ^[Yy]$ ]] ; then
        cd ~/.oh-my-zsh && git pull
            if [[ $? -eq 0 ]]
            then
                success "Update complete..." && cd
            else
                fail "Update not complete..." >&2 cd
            fi
        fi
    else
    echo "oh-my-zsh not found, now installing oh-my-zsh..."
    echo ''
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
    success 'oh-my-zsh installed'
    fi
}

ohmyzshPluginInstall () {
    # oh-my-zsh plugin install
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]; then
        info 'zsh-completions already installed'
    else
        git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && success 'zsh-completions installed'
    fi
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        info 'zsh-autosuggestions already installed'
    else
        git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && success 'zsh-autosuggestions installed'
    fi
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        info 'zsh-syntax-highlighting already installed'
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && success 'zsh-syntax-highlighting installed'
    fi
}

pl9kInstall () {
    # powerlevel9k install
    if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel9k" ]; then
        info 'powerlevel9k already installed'
    else
        echo "Now installing powerlevel9k..."
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k && success 'powerlevel9k installed'
    fi
}

pl10kInstall () {
    # powerlevel10k install
    if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        info 'powerlevel10k already installed'
    else
        echo "Now installing powerlevel10k..."
        git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k && success 'powerlevel10k installed'
    fi
}

tmuxTpmInstall () {
    # tmux tpm install
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        info 'tmux tpm already installed'
    else
        echo "Now installing Tmux TPM manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && success 'tmux tpm manager installed'
    fi
}

vundleInstall () {
    if [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
        info 'vundle already exists'
    else
        # vimrc vundle install
        echo ''
        echo "Now installing vundle..."
        echo ''
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && success 'vundle installed'
    fi
}

pathogenInstall () {
    if [ -f "$HOME/.vim/autoload/pathogen.vim" ]; then
        info 'pathogen already installed'
    else
        mkdir -p ~/.vim/autoload ~/.vim/bundle && \
            curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && success 'pathogen installed'
    fi
}

nerdtreeInstall () {
    if [ -d "$HOME/.vim/bundle/nerdtree" ]; then
        info 'vim nerdtree already installed'
    else
        git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree && success 'vim nerdtree installed'
    fi
}

wombatColorSchemeInstall () {
    if [ -f "$HOME/.vim/colors/wombat.vim" ]; then
        info "wombat color scheme already installed"
    else
        # Vim color scheme install
        git clone https://github.com/sheerun/vim-wombat-scheme.git ~/.vim/colors/wombat 
        mv ~/.vim/colors/wombat/colors/* ~/.vim/colors/
        success 'vim wombat color scheme installed'
    fi
}

# brew setup
brewInstall
brewUpdate

# zsh setup
zshInstall
configureGitCompletion

# oh my zsh setup
ohmyzshInstall
zshZInstall
ohmyzshPluginInstall
pl9kInstall
pl10kInstall
tmuxTpmInstall

#vim setup
vundleInstall
pathogenInstall
nerdtreeInstall
wombatColorSchemeInstall

# Pull down personal dotfiles
echo ''
read -p "Do you want to use jldeen's dotfiles? y/n" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo ''
	echo "Now pulling down jldeen dotfiles..."
	git clone https://github.com/jldeen/dotfiles.git ~/.dotfiles
	echo ''
	cd $HOME/.dotfiles && echo "switched to .dotfiles dir..."
	echo ''
	echo "Checking out macOS branch..." && git checkout mac
	echo ''
	echo "Now configuring symlinks..." && $HOME/.dotfiles/script/bootstrap
    echo ''

    if [[ $? -eq 0 ]]
    then
        echo "Successfully configured your environment with jldeen's macOS dotfiles..."
    else
        echo "jldeen's macOS dotfiles were not applied successfully..." >&2
fi
else 
	echo ''
    echo "You chose not to apply jldeen's macOS dotfiles. You will need to configure your environment manually..."
	echo ''
	echo "Setting defaults for .zshrc and .bashrc..."
	echo ''
	echo "source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added zsh-syntax-highlighting to .zshrc..."
	echo ''
	echo "source $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc && echo "added zsh-autosuggestions to .zshrc..."
	echo ''	
fi
