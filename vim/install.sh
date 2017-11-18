if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -d "$HOME/.vim/autoload" ]; then
  sudo curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi