alias marchnative='gcc -march=native -E -v - </dev/null 2>&1 | grep cc1'
alias password='tr -cd "[:alnum:]" < /dev/urandom | fold -w16 | head -n1'
alias passphrase='tr -cd "[:alnum:]" < /dev/urandom | fold -w32 | head -n1'
alias waitfornet="while ! ping -c 1 -W 1 8.8.8.8 >/dev/null; do sleep 1 ; done"
alias pcat="pygmentize -f terminal256 -O style=native -g"
alias sadserver="python -c \"import requests;print(requests.get('https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=sadserver&count=1',headers={'Authorization':'Bearer `cat ~/.config/twitter`'}).json()[0]['text'])\""

alias oops="sudo \$(history -p \!\!)"
alias `echo ZnVjawo= | base64 -d`=oops
