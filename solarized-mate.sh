#!/bin/bash
set +x
SCHEME=${1:-"light"}
PROFILE=${2:-"default"}
INTERACTIVE=${3:-"1"}

DCONF=`which dconf`

if [ -z $DCONF ]; then
    echo "Please install dconf-cli and dconf-editor"
    exit 1
fi

SCHEMES=(dark light)
echo "Available schemes:"`printf -- ' %s' "${SCHEMES[@]}"`
echo "> You have chosen: '$SCHEME'"

PROFILES=`dconf list /org/mate/terminal/profiles/ | sed 's/\///g'`
echo "Available profile:" `printf -- ' %s' "${PROFILES[@]}"`
echo "> You have chosen: '$PROFILE'"

if [[ "0" != $INTERACTIVE ]]; then
    read -p "continue? [N/y]"
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo
        echo "Abort"
        echo
        echo "HELP:"
        echo "  $0 SCHEME PROFILE"
        echo
        echo "EXEMPLE:"
        echo "  $0 dark profile0"

        exit 1
    fi
fi

COLORS=`cat colors/palette`
if [[ "light" == $SCHEME ]]; then
    BGCOLOR=`cat colors/base3`
    BOLDCOLOR=`cat colors/base01`
    FGCOLOR=`cat colors/base00`
else
    BGCOLOR=`cat colors/base03`
    BOLDCOLOR=`cat colors/base1`
    FGCOLOR=`cat colors/base0`
fi

# Do not use theme color
dconf write /org/mate/terminal/profiles/${PROFILE}/use-theme-colors "false"

# set palette
dconf write /org/mate/terminal/profiles/${PROFILE}/palette \"$COLORS\"

# set highlighted color to be different from foreground-color
dconf write /org/mate/terminal/profiles/${PROFILE}/bold-color-same-as-fg false
dconf write /org/mate/terminal/profiles/${PROFILE}/background-color \"$BGCOLOR\"
dconf write /org/mate/terminal/profiles/${PROFILE}/foreground-color \"$FGCOLOR\"
dconf write /org/mate/terminal/profiles/${PROFILE}/bold_color \"$BOLDCOLOR\"

echo -e "\e[37;41mTerminal must be restarted\e[0m"
