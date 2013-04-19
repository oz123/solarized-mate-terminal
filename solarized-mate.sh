#!/bin/bash 

dconf write  /org/mate/terminal/profiles/default/use-theme-colors "false"

COLORS=`cat colors/palette`
BASE3=`cat colors/base3`
BASE01=`cat colors/base01`
BASE00=`cat colors/base00`

# set palette
dconf write /org/mate/terminal/profiles/default/palette \"$COLORS\"

# set highlighted color to be different from foreground-color
dconf write  /org/mate/terminal/profiles/default/bold-color-same-as-fg false
dconf write /org/mate/terminal/profiles/default/background-color \"$BASE3\"
dconf write /org/mate/terminal/profiles/default/foreground-color \"$BASE00\"
dconf write /org/mate/terminal/profiles/default/bold_color \"$BASE01\"
