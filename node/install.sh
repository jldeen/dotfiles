if test ! $(which spoof)
then
  sudo npm install spoof -g
fi

# install NVM
if test ! $(command -v nvm)
then
  sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
fi