#! /usr/bin/env python3

import filecmp
import os
import sys
from shutil import copyfile

files = [
  ".bash_profile",
  ".bashrc",
  ".gitconfig",
  ".inputrc",
  ".tmux.conf",
  ".vimrc",
  ".config/i3/config",
  ".config/i3status/config",
  ".config/dunst/dunstrc",
  ".local/bin/i3statusxt"
]

def warn(question):
  danger = input(question)
  return danger in [ "y", "Y", "yes", "Yes" ]

def something(question, to, fromm):
  if warn(question):
    for file in files:
      try:
        copyfile(to(file), fromm(file))
      except FileNotFoundError:
        pass

def copy(to_git):
  if to_git:
    something("Copy from git to home? ", lambda x: x, lambda x: os.path.expanduser(f"~/{x}"))
  else:
    something("Copy from home to git? ", lambda x: os.path.expanduser(f"~/{x}"), lambda x: x)

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
  elif len(sys.argv) >= 2 and sys.argv[1] == "copy":
    copy(len(sys.argv) > 2 and sys.argv[2] == "here")
  else:
    print("usage dotfiles.py [copy|diff]")
