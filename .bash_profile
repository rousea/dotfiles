#
# ~/.bash_profile
#

# exec startx at login
#if [[ -z "${DISPLAY}" ]] && [[ "%{XDG_VTNR}" -eq 1 ]]; then
#    exec startx
#fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
