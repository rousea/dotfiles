# TODO: better way of managing all of this

shopt -s dotglob
for file in \.[a-z]*; do
  if [[ -f $file ]]; then
    cp $file ~/
  fi
done

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
