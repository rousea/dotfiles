#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

EDITOR=/usr/bin/vim
PS1="\[\e[01;34m\]\t \[\e[m\]\\[\e[32m\]\W\[\e[m\] > "
PS2='> '

HISTSIZE=10000

export TMUX_VERSION=$(tmux -V | sed -En 's/^tmux ([0-9]+(.[0-9]+)?).*/\1/p')

alias scrcpy="(scrcpy &>/dev/null &)"

if [[ $(uname) == "Darwin" ]]; then
  BROWSER=/Applications/Firefox.app

  PATH=$PATH:/usr/local/sbin/:$HOME/Library/Android/sdk/platform-tools/
  PATH=/usr/local/opt/openjdk@11/bin:$PATH

  alias uart="sudo screen /dev/tty.usbserial 115200"
  alias lock="pmset displaysleepnow"
  export CLICOLOR=1
  export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

  ssh-add -K > /dev/null 2>&1
  ssh-add -L > /dev/null 2>&1

  if [[ -f $HOME/utils/adbhelpers.sh ]]; then
    source $HOME/utils/adbhelpers.sh
  fi

  export GOPATH=/Users/arouse/workspace/go
  alias ll='ls -lh'
  alias lla='ls -lha'

  source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
elif [[ $(uname) == "Linux" ]]; then
  source /usr/share/git/completion/git-completion.bash
  source /usr/share/git/completion/git-prompt.sh

  gitprompt='$(__git_ps1 " (%s)")'
  PS1="\[\e[01;36m\]\t \[\e[m\]\\[\e[33m\]\W\[\e[m\]$gitprompt $ "
  unset gitprompt
  BROWSER=/usr/bin/chromium
  alias ll='ls -lh'
  alias lla='ls -lha'
  alias ls='ls --color=auto'
  eval `dircolors ~/.dircolors/dircolors.nord`

  export GOPATH=~/workspace/go
fi

_git_checkout ()
{
  __git_has_doubledash && return
  case "$cur" in
  --conflict=*)
    __gitcomp "diff3 merge" "" "${cur##--conflict=}"
    ;;
  --*)
    __gitcomp_builtin checkout
    ;;
  *)
    # check if --track, --no-track, or --no-guess was specified
    # if so, disable DWIM mode
    local flags="--track --no-track --no-guess" track_opt="--track"
    if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
    [ -n "$(__git_find_on_cmdline "$flags")" ]; then
      track_opt=''
    fi

    # Modified to support local-only branch completion
    # to user remote branch completion, use alias checkoutr
    #__git_complete_refs $track_opt
    if [ "$command" = "checkoutr" ]; then
      __git_complete_refs $track_opt
    else
      __gitcomp_direct "$(__git_heads "" "$cur" " ")"
    fi
    ;;
  esac
}
