alias ls='ls -alG'
bind -m vi-insert "\C-l":clear-screen
set -o vi

GIT=`which git`
git ()
{
    #
    # alias git commands and set some default flags
    #

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
    export PS1="(`basename $VIRTUAL_ENV`)-[`$GIT branch | grep '*' | cut -c 3-`]: \W\$ " 
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

