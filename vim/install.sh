if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  echo "› installing vundle"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -x "$HOME/.vimrc" ]; then
  echo "› installing vim plugins"
  vim +PluginInstall +qall
fi

# if [ ! -d "$HOME/.vim/autoload" ]; then
#   mkdir ~/.vim/autoload
#   sudo curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# fi
