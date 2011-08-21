alias ls='ls -alG'
set -o vi

# set terminal title
echo -ne "\033]0;${USER}@${HOSTNAME}\007"

# ^p check for partial match in history
bind -m vi-insert "\C-p":dynamic-complete-history

# ^n cycle through the list of partial matches
bind -m vi-insert "\C-n":menu-complete

# ^l clear screen
bind -m vi-insert "\C-l":clear-screen


GIT=`which git`
git ()
{
    #
    # alias git commands and set some default flags
    #
    local ENV
    local BRANCH
    $GIT branch &> /dev/null
    if  [ "$?" == "0" ]; then
        BRANCH="[`$GIT branch | grep '*' | cut -c 3-`]"
    fi
    if [ "$VIRTUAL_ENV" != "" ]; then
        ENV="-(`basename $VIRTUAL_ENV`)"
    fi
    if [ "$1" == "st" ]; then
        shift 1
        $GIT status $@
    elif [ "$1" == "merge" ]; then
        shift 1
        $GIT merge --no-ff $@
    elif [ "$1" == "co" ]; then
        shift 1
        $GIT checkout $@ 
    elif [ "$1" == "ci" ]; then
        shift 1
        $GIT commit $@
    elif [ "$1" == "log" ]; then
        shift 1
        $GIT log --graph $@
    else
        $GIT $@
    fi
    export PS1="\u@\h$ENV$BRANCH:\W\$ " 
}

pyf ()
{
    #
    # run pyflakes on all modified git or svn files
    #

    if [ -d .svn ]; then
        svn st . | egrep "^(M|A)" | cut -c 9- | grep py$ | xargs pyflakes
    else
        git status | egrep "(modified:|new file:)" | cut -c 15- | grep py$ | xargs pyflakes
    fi
}

PYTHONSTARTUP=~/dotfiles/pythonrc.py
export PYTHONSTARTUP
