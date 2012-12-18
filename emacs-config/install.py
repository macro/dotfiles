#!/usr/bin/env python
import os
import subprocess

def install(target, new):
    target = os.path.abspath(os.path.expanduser(target))
    new = os.path.abspath(os.path.expanduser(new))

    if os.path.exists(new):
        print "{0} exists".format(new)
    else:
        os.symlink(target, new)


if __name__ == '__main__':
    install('./emacs-config/emacs.el', '~/.emacs')
    install('./emacs-config', '~/.emacs.d')
    p = subprocess.Popen("git submodule update --init --recursive".split())
    p.wait()
    result = p.communicate()[0]
    if result:
        print result
