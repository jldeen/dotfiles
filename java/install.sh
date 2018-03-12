if [ ! -d "$HOME/.sdkman" ]; then
  echo "› installing sdkman"
  sudo curl -s "https://get.sdkman.io" | bash
fi
