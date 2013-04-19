#!/bin/bash 

dconf write  /org/mate/terminal/profiles/default/use-theme-colors "false"

COLORS=`cat colors/palette`
BASE03=`cat colors/base03`
BASE1=`cat colors/base1`
BASE0=`cat colors/base0`

# set palette
dconf write /org/mate/terminal/profiles/default/palette \"$COLORS\"

# set highlighted color to be different from foreground-color
dconf write  /org/mate/terminal/profiles/default/bold-color-same-as-fg false
dconf write /org/mate/terminal/profiles/default/background-color \"$BASE03\"
dconf write /org/mate/terminal/profiles/default/foreground-color \"$BASE0\"
dconf write /org/mate/terminal/profiles/default/bold_color \"$BASE1\"
