#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

HISTFILESIZE=2500
export EDITOR="vim"
export VISUAL="$EDITOR"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[ -n "`which ix 2>/dev/null`" ] || alias ix="curl -F 'f:1=<-' ix.io"
password(){ len=${1:-16};ct=${2:-1};tr -cd "[:alnum:]"</dev/urandom|fold -w"$len"|head -n"$ct";}

if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi
if [ -d "$HOME/sources/android/sdk/platform-tools" ] ; then
    export PATH="$PATH:$HOME/sources/android/sdk/platform-tools"
fi

eval $(dircolors ~/.dircolors)

[ -x "$HOME/.bashrc.local" ] && . $HOME/.bashrc.local

