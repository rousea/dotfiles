[[ -f ~/.xprofile ]] &&  source ~/.xprofile
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources
exec i3
