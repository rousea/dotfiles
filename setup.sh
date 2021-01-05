# TODO: better way of managing all of this
#!/usr/bin/env bash

# should check to make sure we're not clobbering anything
cp .bash_profile $HOME/
cp .bashrc $HOME/
cp .gitconfig $HOME/
cp .i3config $HOME/.config/i3/config
cp .i3statusconfig $HOME/.config/i3status/config
cp .ideavimrc $HOME/
cp .inputrc $HOME/
cp .ssh_rc $HOME/
cp .tmux_conf $HOME/
cp .xinitrc $HOME/
cp .xprofile $HOME/
cp .Xresources $HOME/

if [[ $(uname) == "Linux" ]]; then
  if [[ ! -d ~/.dircolors && ! -a ~/.dircolors ]]; then
    mkdir ~/.dircolors
    curl -LJ https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark -o ~/.dircolors/dircolors.256dark
  fi
fi

if [[ ! -d ~/.vim/colors && ! -a ~/.vim/colors ]]; then
  mkdir ~/.vim/colors
  curl -LJ https://raw.githubusercontent.com/junegunn/seoul256.vim/master/colors/seoul256.vim -o ~/.vim/colors/seoul256.vim
fi

source .bash_profile
