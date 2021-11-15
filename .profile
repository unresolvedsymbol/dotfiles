export XDG_RUNTIME_DIR=$HOME/.cache/xdgr
# Just updated void, where the fuck did /run/user/uid go?

export PREFIX="$HOME/.local" # Install local programs, libraries, etc in your home instead of polluting the root
# these break a lot of shit when building with other toolchains so uh
#export CPLUS_INCLUDE_PATH="$PREFIX/include:/usr/local/include:/usr/include"
#export PKG_CONFIG_PATH="$PREFIX/lib64/pkgconfig:$PREFIX/lib/pkgconfig:$PREFIX/share/pkgconfig:/usr/local/share/pkgconfig:/usr/share/pkgconfig"
#export C_INCLUDE_PATH="$PREFIX/include:/usr/local/include:/usr/include"

# Help
# PROBLEMATIC FOR APPIMAGES MOSTLY run with "env -u LD_LIBRARY_PATH ./your-app-image"
export LD_LIBRARY_PATH="$PREFIX/lib:/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH"
# You typically are supposed to add a file in /etc/ld.so.conf.d/ with this path $PREFIX/lib 
# But for some fucking reason ldconfig won't do it's motherfucking job

export ANDROID_JAVA_HOME="$JAVA_HOME"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk-bundle"
export DEVKITPPC="/opt/devkitpro/devkitPPC"
export WUT_ROOT="/opt/devkitpro/wut"
export VITASDK="$PREFIX/opt/vitasdk"

export PBL_TOOL_PATH="$HOME/pebble-dev/pebble-sdk-4.5-linux64/bin"
export PATH="$PBL_TOOL_PATH:$PREFIX/sbin:$PREFIX/bin:$PATH:$ANDROID_HOME/platform-tools:$ANDROID_NDK_HOME:$HOME/go/bin:$DEVKITPRO/tools/bin:$DEVKITARM/bin:$VITASDK/bin"
#export LIBRARY_PATH="$HOME:/.local/lib64:$PREFIX/lib:/usr/local/lib:/usr/lib"
export MANPATH="$PREFIX/share/man:/usr/local/share/man:/usr/share/man"
export INFODIR="$PREFIX/share/info:/usr/share/info:/usr/local/share/info"

export EDITOR="vim"
export TERMCMD="footclient"
export BROWSER="chrome"
export PAGER="less"

# Theming
export QT_STYLE_OVERRIDE=kvantum
export QT_AUTO_SCREEN_SCALE_FACTOR=1
# Equalize GDK-QT font scale..? Why does this need to be done?
export QT_SCALE_FACTOR=1.25

# Include other wal shell variables and such
[ -e ~/.cache/wal/colors.sh ] && source ~/.cache/wal/colors.sh

[ -d ~/.local/etc/profile.d/ ] && {
    for f in ~/.local/etc/profile.d/*; do
        [ -r "$f" ] && source "$f"
    done
    unset f
}
