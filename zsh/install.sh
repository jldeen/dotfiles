CUSTOM_DIR = ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

echo "› re-installing powerlevel9k theme"
rm -rf ${CUSTOM_DIR}/themes/powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ${CUSTOM_DIR}/themes/powerlevel9k

echo "› re-installing zsh-autosuggestions"
rm -rf ${CUSTOM_DIR}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${CUSTOM_DIR}/plugins/zsh-autosuggestions

echo "› re-installing zsh-syntax-highlighting"
rm -rf ${CUSTOM_DIR}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${CUSTOM_DIR}/plugins/zsh-syntax-highlighting
