export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}

if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi

export MOSH_TITLE_NOPREFIX=1 # Disable [mosh] prefix
export KRB5CCNAME="DIR:/tmp/krb5cc_${UID}_d/"

# Hack around lack of XDG base dir spec support
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle \
       BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle \
       BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle # Ruby bundler
export CARGO_HOME="$XDG_DATA_HOME"/cargo # Rust cargo
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME"/ccache.config
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GVIMINIT=":source $XDG_CONFIG_HOME"/vim/gvimrc
export LESSHISTFILE="$XDG_CACHE_HOME"/lesshst
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NUGET_PACKAGES="$XDG_CACHE_HOME"/nuget-packages
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/startup.py
export RANDFILE="$XDG_DATA_HOME"/openssl/rnd
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export VIMINIT=":source $XDG_CONFIG_HOME"/vim/vimrc
export WEECHAT_HOME="$XDG_CONFIG_HOME"/weechat
export WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export XINITRC="$XDG_CONFIG_HOME"/xinitrc
