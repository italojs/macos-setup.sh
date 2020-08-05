GREEN="\033[0;32m"
NC="\033[0m" # No Color
LIGHT_GREY="\033[0;37m"
YELLOW="\033[1;33m"

PRINT(){
    MESSAGE=$1
    echo "> ${MESSAGE} ${NC}"
}

INSTALL_APP(){
    APP=$1
    CASK=$2 

    PRINT "Can I install ${GREEN} ${APP} ${NC}? (y/n)"
    read input
    if echo "$input" | grep -iq "^y" ;then
        PRINT "Installing ${GREEN} ${APP} ${NC}..."
        brew $CASK install $APP
    fi
    clear
}

PRINT "${YELLOW}Are you have installed Apple's Command Line Tools before run this script? (y/n)"
read input
if echo $input | grep -iq "^y" ;then
	PRINT "Niiice! Let's continue configuring your beautiful Macbook! :D"
else
	PRINT "Please, run 'xcode-select --install' before this script"
fi

PRINT "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
clear

PRINT "Updating zsh..."
brew install zsh
clear

# This session was copied from github.com/ErickWendel/ew-ubuntu-setup
PRINT "What name do you want to use in GIT user.name?"
PRINT "For example, mine will be \"Italo Jose\""
read input
git config --global user.name "$input"
clear 

PRINT "What email do you want to use in GIT user.email?"
PRINT "For example, mine will be \"italo.i@live.com\""
read input
git config --global user.email $input
clear

PRINT "Can I set VIM as your default GIT editor for you? (y/n)"
read input
if echo "$input" | grep -iq "^y" ;then
	git config --global core.editor vim
fi
clear

PRINT "Generating a SSH Key..."
ssh-keygen -t rsa -b 4096 -C $git_config_user_email
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

PRINT "Enabling workspaces for both screens..."
gsettings set org.gnome.mutter workspaces-only-on-primary false
clear

PRINT "Installing Oh-My-Zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
clear

PRINT "Do you want to configure your terminal with powerlevel10k? (y/n)"
PRINT "${LIGHT_GREY}know more about powerlevel10k in https://github.com/romkatv/powerlevel10k"
read input
if echo $input | grep -iq "^y" ;then
    brew install romkatv/powerlevel10k/powerlevel10k
    echo "source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme" >>! ~/.zshrc
fi
clear

INSTALL_APP "node"
INSTALL_APP "docker" "cask"
INSTALL_APP "iterm2" "cask"
INSTALL_APP "alfred" "cask"
INSTALL_APP "google-chrome" "cask"
INSTALL_APP "firefox" "cask"
INSTALL_APP "spotify" "cask"
INSTALL_APP "whatsapp" "cask"
INSTALL_APP "telegram" "cask"
INSTALL_APP "notion" "cask"





