# .bashrc

# User specific aliases and functions

PS1="\n\w\n[\u@\h]\\$ "
TERM="xterm-color"
PATH="/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:/usr/ccs/bin:/usr/openwin/bin"
MANPATH="/usr/share/man:/usr/local/man"
EDITOR="vi"
VISUAL="vi"
PAGER="less"
FTP_PASSIVE="1"

export PS1 TERM PATH MANPATH EDITOR VISUAL PAGER FTP_PASSIVE
set -o vi

alias ll='ls -l'
alias la='ls -la'
alias rm='/bin/rm -i'
alias mv='/bin/mv -i'
alias cp='/bin/cp -i'
alias motd='/bin/cat /etc/motd'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
