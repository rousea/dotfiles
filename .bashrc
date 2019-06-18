#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

EDITOR=/usr/bin/vim
PS1="\[\e[01;35m\]\t \[\e[m\]\\[\e[33m\]\W\[\e[m\] > "
PS2='> '

HISTSIZE=10000

if [[ $(uname) == "Darwin" ]]; then
  BROWSER=/Applications/Firefox.app

  PATH=$PATH:$HOME/Library/Android/sdk/platform-tools/

  alias uart="sudo screen /dev/tty.usbserial 115200"
  alias lock="pmset displaysleepnow"
  export CLICOLOR=1
  export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

  ssh-add -K > /dev/null 2>&1
  ssh-add -L > /dev/null 2>&1

  if [[ -f utils/adbhelpers.sh ]]; then
    source utils/adbhelpers.sh
  fi

  export GOPATH=/Users/arouse/workspace/go
  alias ll='ls -lh'
  alias lla='ls -lha'

  source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
elif [[ $(uname) == "Linux" ]]; then
  # nothing yet
  PS1="\[\e[01;35m\]\t \[\e[m\]\\[\e[33m\]\W\[\e[m\] $ "
  BROWSER=/usr/bin/chromium
  alias ll='ls -lh --color=auto'
  alias lla='ls -lha --color=auto'
  eval `dircolors ~/.dircolors/dircolors.256dark`
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
