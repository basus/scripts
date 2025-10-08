#!/usr/bin/env sh


echo "tell application \"System Events\" to keystroke \"$1\" \
    using {control down, shift down, option down, command down}"  | osascript
