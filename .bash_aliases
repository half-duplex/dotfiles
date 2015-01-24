alias marchnative='gcc -march=native -E -v - </dev/null 2>&1 | grep cc1'
alias password='tr -cd "[:alnum:]" < /dev/urandom | fold -w16 | head -n1'
alias waitfornet="while ! ping -c 1 -W 1 8.8.8.8 >/dev/null; do sleep 1 ; done"

alias oops="sudo \"\$(history -p \!\!)\""
alias `echo ZnVjawo= | base64 -d`=oops
