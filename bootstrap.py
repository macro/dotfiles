#!/usr/bin/env python
import os
import subprocess


def setup_symlink(source, link):
    source = os.path.abspath(os.path.expanduser(source))
    link = os.path.abspath(os.path.expanduser(link))

    if os.path.exists(link):
        print "WARNING: {0} exists".format(link)
    else:
        print '{} -> {}'.format(source, link)
        os.symlink(source, link)

def setup_emacs_local(fn='./emacs-config/local.el'):
    fn = os.path.abspath(os.path.expanduser(fn))
    if os.path.exists(fn):
        print "WARNING: {0} exists".format(fn)
    else:
        with open(fn, 'w') as f:
            f.write('(load "macro")')

def setup_submodules():
    p = subprocess.Popen("git submodule update --init --recursive".split())
    p.wait()
    result = p.communicate()[0]
    if result:
        print result

if __name__ == '__main__':
    setup_submodules()

    # dotfiles
    setup_symlink('./inputrc', '~/.inputrc')
    setup_symlink('./hgrc', '~/.hgrc')
    setup_symlink('./pythonrc.py', '~/.pythonrc')
    setup_symlink('./bashrc', '~/.bashrc')

    # vim
    setup_symlink('./dotfiles', '~/.vim')

    # emacs
    setup_symlink('./emacs-config/emacs.el', '~/.emacs')
    setup_symlink('./emacs-config', '~/.emacs.d')
    setup_emacs_local()
