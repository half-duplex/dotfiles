#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Migrate history file to XDG-compliant location
oldhistfile="$HISTFILE"
HISTFILE="${XDG_DATA_HOME}/bash/history"
[ ! -e "$HISTFILE" ] && mkdir -p $(dirname "$HISTFILE") && mv "$oldhistfile" "$HISTFILE"
unset oldhistfile

HISTSIZE=5000
HISTCONTROL="ignoreboth"
HISTTIMEFORMAT="%Y.%m.%d %T "
export EDITOR="vim"
export VISUAL="$EDITOR"

if [ -f ~/.bash_aliases ]; then
    mkdir -p "$XDG_CONFIG_HOME/bash"
    mv ~/.bash_aliases "$XDG_CONFIG_HOME/bash/aliases"
fi
if [ -f "$XDG_CONFIG_HOME/bash/aliases" ]; then
    . "$XDG_CONFIG_HOME/bash/aliases"
fi

which ix &>/dev/null || alias ix="curl -F 'f:1=<-' ix.io"
badpassword(){ len=${1:-32};ct=${2:-1};tr -cd "[:alnum:]"</dev/urandom|fold -w"$len"|head -n"$ct";}
# All printable chars that terminals don't count as splitting words
password(){ len=${1:-32};ct=${2:-1};tr -cd '[:alnum:]#%+,\-./=?@\\_~'</dev/urandom|fold -w"$len"|head -n"$ct";}

if [ -d "$HOME/sources/android/sdk/platform-tools" ] ; then
    export PATH="$PATH:$HOME/sources/android/sdk/platform-tools"
fi

[ -x "$HOME/.bashrc.local" ] && . $HOME/.bashrc.local
