export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}

if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export GVIMINIT=":source $XDG_CONFIG_HOME/vim/gvimrc"
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export RANDFILE="$XDG_DATA_HOME/openssl/rnd"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export XINITRC="$XDG_CONFIG_HOME/xinitrc"

export CL_PROPERTIES="$XDG_CONFIG_HOME/clion/config/idea.properties"
export PYCHARM_PROPERTIES="$XDG_CONFIG_HOME/pycharm/config/idea.properties"
export DATAGRIP_PROPERTIES="$XDG_CONFIG_HOME/datagrip/config/idea.properties"
export STUDIO_PROPERTIES="$XDG_CONFIG_HOME/studio/config/idea.properties"
export WEBIDE_PROPERTIES="$XDG_CONFIG_HOME/webide/config/idea.properties"
export PHPSTORM_PROPERTIES="$XDG_CONFIG_HOME/phpstorm/config/idea.properties"
export YOURKIT_HOME="$XDG_CACHE_HOME/yourkitjava"
