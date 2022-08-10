#!/bin/bash


current=$(defaults read com.apple.menuextra.clock IsAnalog)

if [[ $current == 0 ]]; then
    defaults write com.apple.menuextra.clock IsAnalog -bool true && echo "Big Sur Analog enabled"
elif [[ $current == 1 ]]; then
    defaults write com.apple.menuextra.clock IsAnalog -bool false && echo "Big Sur Analog disabled"
fi

