#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

EDITOR=/usr/bin/vim
PS2='> '

if [[ $(uname) == "Darwin" ]]; then
  PS1='\t \W $ '
  BROWSER=/Applications/Firefox.app

  alias uart="sudo screen /dev/tty.usbserial 115200"
  alias lock="pmset displaysleepnow"
  export CLICOLOR=1

  ssh-add -K > /dev/null 2>&1
  ssh-add -L > /dev/null 2>&1

  if [[ -f adbhelpers.sh ]]; then
    source adbhelpers.sh
  fi
elif [[ $(uname) == "Linux" ]]; then
  # nothing yet
  PS1="\[\e[01;35m\]\t \[\e[m\]\\[\e[33m\]\W\[\e[m\] > "
  BROWSER=/usr/bin/chromium
  alias ls='ls --color=auto'
  eval `dircolors ~/.dircolors/dircolors.256dark`
fi
