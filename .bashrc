#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR="vim"


6p() { curl -s -F "content=<${1--}" -F ttl=604800 -w "%{redirect_url}\n" -o /dev/null https://p.6core.net/; }

alias marchnative='gcc -march=native -E -v - </dev/null 2>&1 | grep cc1'
alias password='tr -cd "[:alnum:]" < /dev/urandom | fold -w16 | head -n1'

if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi

