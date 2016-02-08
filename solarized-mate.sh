#!/bin/bash

which dconf || { echo "Please install dconf-cli"; exit 1; }

if [[ $1 == "--reset" ]]; then
   dconf reset -f /org/mate/terminal/global/profile-list
   dconf reset -f /org/mate/terminal/profiles
   exit 0
fi
# read profiles as string
PROFILES=`dconf read /org/mate/terminal/global/profile-list`
# add new profiles

if [ -z "${PROFILES}" ]; then
	PROFILES="['default','solarized-dark', 'solarized-light']"
else	
    if [[ ${PROFILES} =~ 'solarized-dark' || ${PROFILES} =~ 'solarized-light' ]]; then
    	echo "Found solarized in your themes, refusing to run twice"
        echo "You can reset these setting with"
        echo `basename "$0"` "--reset"
        exit 1
    else
		M="'solarized-dark', 'solarized-light']"
		PROFILES=${PROFILES/\']/, $M}
    fi
fi

dconf write /org/mate/terminal/global/profile-list "${PROFILES}"

COLORS=`cat colors/palette`
BGCOLOR=`cat colors/base03`
BOLDCOLOR=`cat colors/base1`
FGCOLOR=`cat colors/base0`

PROFILE="solarized-dark"
# Do not use theme color
dconf write /org/mate/terminal/profiles/${PROFILE}/use-theme-colors false

# set palette
dconf write /org/mate/terminal/profiles/${PROFILE}/palette \"$COLORS\"
# set highlighted color to be different from foreground-color
dconf write /org/mate/terminal/profiles/${PROFILE}/bold-color-same-as-fg false
dconf write /org/mate/terminal/profiles/${PROFILE}/background-color \"$BGCOLOR\"
dconf write /org/mate/terminal/profiles/${PROFILE}/foreground-color \"$FGCOLOR\"
dconf write /org/mate/terminal/profiles/${PROFILE}/bold-color \"$BOLDCOLOR\"
dconf write /org/mate/terminal/profiles/${PROFILE}/visible-name \"solarized-dark\"

BGCOLOR=`cat colors/base3`
FGCOLOR=`cat colors/base00`


PROFILE="solarized-light"
# Do not use theme color
dconf write /org/mate/terminal/profiles/${PROFILE}/use-theme-colors false

# set palette
dconf write /org/mate/terminal/profiles/${PROFILE}/palette \"$COLORS\"
# set highlighted color to be different from foreground-color
dconf write /org/mate/terminal/profiles/${PROFILE}/bold-color-same-as-fg false
dconf write /org/mate/terminal/profiles/${PROFILE}/background-color \"$BGCOLOR\"
dconf write /org/mate/terminal/profiles/${PROFILE}/foreground-color \"$FGCOLOR\"
dconf write /org/mate/terminal/profiles/${PROFILE}/bold-color \"$BOLDCOLOR\"
dconf write /org/mate/terminal/profiles/${PROFILE}/visible-name \"solarized-light\"

echo -e "\e[37;41mTerminal must be restarted\e[0m"
