# build python tags file in current director (needs exuberant tags)
alias pytags="ctags -R --python-kinds=-i --languages=python . ${1}"

alias ll='ls -alG'
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

#
# funcs
#
GIT=`which git`
git ()
{
    #
    # alias git commands and set some default flags
    #
    local ENV
    local BRANCH
    local BRANCH_LABEL
    $GIT branch &> /dev/null
    if  [ "$?" == "0" ]; then
        BRANCH=`$GIT branch | grep '*' | cut -c 3-`
        BRANCH_LABEL="[${BRANCH}]"
    fi
    if [ "$VIRTUAL_ENV" != "" ]; then
        ENV="-(`basename $VIRTUAL_ENV`)"
    fi
    if [ "$1" == "merge" ]; then
        shift 1
        $GIT merge $@
    elif [ "$1" == "log" ]; then
        shift 1
        $GIT log --graph $@
    elif [ "$1" == "fetchall" ]; then
        ${GIT} fetch
        ${GIT} checkout master && git pull
        ${GIT} checkout develop && git pull
        ${GIT} checkout ${BRANCH}
    else
        $GIT $@
    fi
    export PS1="\u@\h$ENV${BRANCH_LABEL}:\W\$ " 
}

pyf ()
{
    #
    # run flake8 on all modified git or svn files
    #
    if [ -d .svn ]; then
        svn st . | egrep "^(M|A)" | cut -c 9- | grep py$ | xargs flake8
    else
        git status | egrep "(modified:|new file:)" | cut -c 15- | grep py$ | xargs flake8
    fi
}

#
# envvars
#
export PYTHONSTARTUP=~/dotfiles/pythonrc.py
export PS1="\u@\h:\W\$ " 
export PAGER='less -XFRS'
export EDITOR=vim

