#!/usr/bin/env python
# dotfiler.py -- install or update dotfiles

from __future__ import print_function
import os

DRY_RUN = False
EXCL_FILES = ['.git', '.gitignore', 'dotfiler.py']
EXCL_SUFFIX = ('.swp', '~')

HOME = os.path.expanduser('~') + "/"

if os.getcwd() != os.path.dirname(os.path.realpath(__file__)):
    raise OSError("Please run this from the same directory it's located in")

FILELIST = [y for y in
            [x for x in os.listdir('.') if x not in EXCL_FILES]
            if not os.path.basename(y).endswith(EXCL_SUFFIX)]


def linkpath(obj):
    """Return the path to obj's symlink."""
    return HOME + "." + obj


def is_linked(obj):
    """True if obj is symlinked into home."""
    objlink = linkpath(obj)
    realpath = os.path.realpath
    state = os.path.islink(objlink) and realpath(obj) == realpath(objlink)
    print("linked" if state else "not linked")
    return state


for df in FILELIST:
    print("{0} is.. ".format(df), end='')
    if not is_linked(df):
        if os.path.exists(linkpath(df)):
            print("{0} already exists in {1}, not linking!".format(df, HOME))
            continue
        if not DRY_RUN:
            print("linking {0}".format(df))
            os.symlink(os.path.realpath(df), linkpath(df))
        else:
            print("would link {0} but DRY_RUN=True".format(df))
