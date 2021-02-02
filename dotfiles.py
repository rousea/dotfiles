#! /usr/bin/env python3

import filecmp
import os
import sys
from shutil import copyfile

# TODO: make sure we're not clobbering any files

files = [
  ".bash_profile",
  ".bashrc",
  ".gitconfig",
  ".inputrc",
  ".tmux.conf",
  ".vimrc",
  ".config/i3/config",
  ".config/i3status/config"
]

def copy(git_to_local):
  if git_to_local:
    danger = input("Are you sure you want to overwrite your local files? ")
    if danger == "y":
      for file in files:
        try:
          copyfile(file, os.path.expanduser(f"~/{file}"))
        except FileNotFoundError:
          pass
  else:
    for file in files:
      try:
        copyfile(os.path.expanduser(f"~/{file}"), file)
      except FileNotFoundError:
        pass

def diff():
  for file in files:
    try:
      if not filecmp.cmp(file, os.path.expanduser(f"~/{file}")):
        print(f"{file} changed")
    except FileNotFoundError:
      pass

if __name__ == "__main__":
  if len(sys.argv) < 2:
    print("usage dotfiles.py [copy|diff]")
    sys.exit(1)

  if sys.argv[1] == "diff":
    diff()
  elif len(sys.argv) == 2 and sys.argv[1] == "copy":
    copy(sys.argv[2] == "local")
  else:
    print("usage dotfiles.py [copy|diff]")
