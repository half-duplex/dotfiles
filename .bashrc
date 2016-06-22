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

6p() { curl -s -F "content=<${1--}" -F ttl=604800 -w "%{redirect_url}\n" -o /dev/null https://p.6core.net/; }

if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi
if [ -d "$HOME/sources/android/sdk/platform-tools" ] ; then
    export PATH="$PATH:$HOME/sources/android/sdk/platform-tools"
fi

eval $(dircolors ~/.dircolors)

[ -x "$HOME/.bashrc.local" ] && . $HOME/.bashrc.local

