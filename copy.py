#! /usr/bin/env python3

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

if len(sys.argv) > 1 and sys.argv[1] == "local":
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
