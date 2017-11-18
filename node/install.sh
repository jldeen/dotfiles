if test ! $(which spoof)
then
  sudo npm install spoof -g
fi

# install NVM
if test ! $(which nvm)
then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
fi