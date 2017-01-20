# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    return
fi

# replace bash with screen instance
#if [[ $TERM != "screen" && $HOSTNAME != "atl-srv-sw14" ]]
#if [[ $TERM != "screen" ]]
#then
#    exec screen -dR
#fi


#if [ "$HOSTNAME" == "atl-srv-sw14" ] ;
#then 
#    tmux
#fi

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

#################################################
##               VARIABLES                     ##
#################################################
export HISTCONTROL=ignoreboth       # don't store duplicates nor empty commands in bash history
export HISTTIMEFORMAT="%c "         # show timestamp in bash history
export HISTSIZE=2000                # size of the history list in the shell
export HISTFILESIZE=200000          # size of the history file
shopt -s histappend                 # append history from the shell to the history on exit
export LESS="-i -S -M -r" # less default options -i ignores case, -S chops long lines, -F quits if only one page -M more verbose prompt (percentage), -r raw colors
export PAGER="/usr/bin/less $LESS" # default pager
export EDITOR=vim
export BROWSER=chromiun-browser
# the PATH
export PATH=/usr/local/bin:/etc:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11R6/bin:/opt/eldk-4.1/bin:/opt/kde3/bin:/opt/mipsel.tools/bin:.
export PATH=~/bin:./:~/usr/bin:$PATH
#export DEBUG=YES

# I don't know if it works...
# DISPLAY
# if test -z "$DISPLAY" -a "$TERM" = "xterm" -a -x /usr/bin/who ; then
#     WHOAMI="`/usr/bin/who am i`"
#     _DISPLAY="`expr "$WHOAMI" : '.*(\([^\.][^\.]*\).*)'`:0.0"
#     if [ "${_DISPLAY}" != ":0:0.0" -a "${_DISPLAY}" != " :0.0" \
#          -a "${_DISPLAY}" != ":0.0" ]; then
#         export DISPLAY="${_DISPLAY}";
#     fi
#     unset WHOAMI _DISPLAY
# fi
if [[ "$HOSTNAME" == "topaz" ]]
then
    export DISPLAY=":4"
else
    unset DISPLAY
fi;

export DISPLAY=:0

# old PS1
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] '

#################################################
##               OPTIONS                       ##
#################################################

# set vi-like key bindings
set -o vi

ulimit -c unlimited

# fancy colors 
if [[ -e ~/.bash_colors ]]; then
    source ~/.bash_colors
    #export PS1="\[$txtgrn\]\t\[$txtrst\]@\[$txtblu\]\h\[$txtylw\] \w \$\[$txtrst\] "
    export PS1="\[$txtgrn\]\d \t\[$txtrst\]@\[$txtblu\]\h\[$txtrst\]\[$txtylw\] \w\n\$\[$txtrst\] "
fi

# bash completion
for i in `ls ~/.bash_completion.d`
do
    source ~/.bash_completion.d/$i
done

if [ -f /etc/bash_completion ]
then
   source /etc/bash_completion
fi

#################################################
##       ALIASES AND FUNCTIONS                 ##
#################################################

alias startvnc="vncserver :4 -geometry 1650x930"
alias ls="ls -hF --color=always"
alias ll="ls -la"
alias rm='rm -i'
alias gitka="gitk --all"
alias abspath="readlink -f"
alias grep='grep --color=always'
alias scr="screen -dR"
alias cleandb='rm -rf $MYSB/ncu/common/db/raima/cserverdb/*'
alias rmcore='rm -f *core*'
alias ssh.k3='ssh root@$IP_ADDR_K3'
alias ssh.ncu1='ssh root@$IP_ADDR_NCU1'
alias ssh.1hu='ssh root@$IP_ADDR_1HU'
alias orb='gob; orbservices &'
alias tfs='gob; tfserver -d ../../common/db/raima/ -p 1630 &'
alias tcl='tcli-start --go'
alias svn.diff='svn di --diff-cmd svn_vimdiff'
alias act_virtualenv='source /home/michalp/usr/virtualpython/bin/activate'
alias relogin="exec bash -l"
alias gcovr-preh='gcovr --object-directory=$PWD --exclude=.*\(buildenv\|\/test\/\|\/test_doubles\/\|\/include\/\).* -b --exclude-unreachable-branches --html --html-details -o gcovr-html/coverage.html -v -k'

# search for specified process name and display its details
function psg ()
{
    if e=`pgrep $*`;
    then 
        ps -Fp $e;
    else
        echo "no matches";
    fi;
}

# search for specified process name owned by me and display its details
function mpsg ()
{
    if e=`pgrep $*`;
    then
        me=`id -nu`;
        ps -fp`pgrep -U $me $*`;
    else
        echo "no matches";
    fi;
}

#Removes shared memory keys
function shmclean()
{
   for i in `ipcs | grep $USER | cut -f1 -d' '`
   do
      ipcrm -M $i
      ipcrm -S $i
   done
}

###### moved to /home/michalp/tools/ctagsgen.sh ###########
##generate ctags for cserver
#function ctagsgen()
#{
#   rm -f ~/.vim/tags/cscope.files
#   for path in $*;
#   do
#       find $path \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hh' -o -name '*.ext' \) -print >> ~/.vim/tags/cscope.files
#   done;
#   ctags -L ~/.vim/tags/cscope.files -a --c-kinds=+p --fields=+iaS --extra=+q --tag-relative=yes -f ~/.vim/tags/tags.ctags
#}
###########################################################


# F7 build
alias mk="make"
alias mkc='mk clean'
alias mkf='mk -j5'
alias mkff='mk -j10'
alias mkflint='make FLINT=YES'
#CS_OPTS="-v3 -o -D -E -i -ou"
CS_OPTS="-v3 -o -ou"
