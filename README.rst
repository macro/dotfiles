Bootstrap
---------

Fetch dependencies and setup vim and emacs dotfiles:

::

    $ git clone https://github.com/macro/dotfiles
    $ cd dotfiles
    $ python ./bootstrap.py


Adding plugins or extensions:

::

    $ git submodule add https://github.com/altercation/vim-colors-solarized dotvim/bundle/solarized
    $ git add .

    $ git submodule add https://github.com/dimitri/el-get emacs-config/vendor/el-get
    $ vim ./emacs-config/macro.el  # add line to ./emacs-config/macro.el to load extension

    $ git ci
