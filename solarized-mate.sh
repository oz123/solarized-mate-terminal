#!/bin/bash 

dconf write  /org/mate/terminal/profiles/default/use-theme-colors "false"

COLORS=`cat colors/palette`
BASE03=`cat colors/base03`
BASE01=`cat colors/base01`

# set palette
dconf write /org/mate/terminal/profiles/default/palette \"$COLORS\"

# set highlighted color to be different from foreground-color
dconf write  /org/mate/terminal/profiles/default/bold-color-same-as-fg false
dconf write /org/mate/terminal/profiles/default/background-color \"$BASE03\"
dconf write /org/mate/terminal/profiles/default/foreground-color \"$BASE01\"
