Vim Configuration
=================

Adding Bundles
--------------:: 

    cd ~/dotfiles
    git submodule add https://github.com/altercation/vim-colors-solarized

    git add .
    git ci -m "Added the solarized bundle"

Reference
---------

Folding
^^^^^^^::

    zR    open all folds
    zM    close all folds
    za    toggle fold at cursor position
    zj    move down to start of next fold
    zk    move up to end of previous fold
