#!/bin/bash

PROFILE=${1:-"default"}

read -p "Update profile: '$PROFILE', continue? [N/y]"
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Abort"

    exit 1
fi


COLORS=`cat colors/palette`
BASE3=`cat colors/base3`
BASE01=`cat colors/base01`
BASE00=`cat colors/base00`

# Do not use theme color

dconf write /org/mate/terminal/profiles/${PROFILE}/use-theme-colors "false"
# set palette
dconf write /org/mate/terminal/profiles/${PROFILE}/palette \"$COLORS\"

# set highlighted color to be different from foreground-color
dconf write /org/mate/terminal/profiles/${PROFILE}/bold-color-same-as-fg false
dconf write /org/mate/terminal/profiles/${PROFILE}/background-color \"$BASE3\"
dconf write /org/mate/terminal/profiles/${PROFILE}/foreground-color \"$BASE00\"
dconf write /org/mate/terminal/profiles/${PROFILE}/bold_color \"$BASE01\"
