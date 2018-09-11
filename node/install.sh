if test ! $(which spoof)
then
  sudo npm install spoof -g
fi

# install NVM
if [ ! -d "$HOME/.nvm" ]; then
  sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
fi
