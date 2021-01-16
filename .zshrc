#
## Oh My Zsh History excerpt (with some changes)
#
#

# Help
export LD_LIBRARY_PATH="$PREFIX/lib:/usr/local/lib:/usr/lib:$LD_LIBRARY_PATH"

: << EOF
[ "$WAYLAND_DISPLAY" ] && {
	export SDL_VIDEODRIVER=wayland
	# breaks some apps
	export GDK_BACKEND=wayland
	export _JAVA_AWT_WM_NONREPARENTING=1 # Fix for some java stuff on wl
	export QT_WAYLAND_FORCE_DPI=physical
	export QT_QPA_PLATFORM=wayland-egl # Problematic occasionally
	export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
	export QT_SCALE_FACTOR=1.25
}

[ "$XDG_SESSION_TYPE" = "wayland" ] && {
	#
}
EOF

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

setopt extended_history		  # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups		  # ignore duplicated commands history list
setopt hist_ignore_space	  # ignore commands that start with space
setopt hist_verify			  # show command with history expansion to user before running it
setopt inc_append_history	  # add commands to HISTFILE in order of execution
setopt share_history		  # share command history data

# Enable autocompletion
FPATH=$PREFIX/share/zsh/site-functions:$FPATH
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

#
## Terminal conditionals (styling, etc)
#

[[ $(tty) =~ tty ]] && {
	source ~/.cache/wal/colors-tty.sh

	# Replace caps with escape (requires you to setuid the loadkeys binary)
	sudo loadkeys <<<"keycode 58 = Escape"

	# Hotfix
	true
} || {
	(cat ~/.cache/wal/sequences &) # Set wal colors, you may not want this on terminals that already have wal includes as I've had it break background transparency before on urxvt

	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
		dir
		dir_writable
		vcs
	)

	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
		status
		background_jobs
	)

	source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
}

# Vi mode setup
source ~/.config/zsh-vimode-visual/zsh-vimode-visual.zsh

# Enable commentary
setopt interactivecomments

#
## Aliases
#

#alias ls="ls --color=auto"
#alias l="ls -alFh"
#alias la="ls -a"

alias ls="exa --color=auto --group-directories-first"
alias la="exa -a --color=auto --group-directories-first"
alias l="exa -l --color=auto --group-directories-first"
alias l.="exa -ad --color=auto --group-directories-first .*"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# I use these mainly for auto complete as it doesn't work with tuxc, etc
alias xq="xbps-query --regex -R -s"
alias xf="xbps-query -f"
alias xi="sudo -E xbps-install"
alias xr="sudo -E xbps-remove -R"
alias xu="sudo -E xbps-install -Su"
alias xa="sudo -E xbps-alternatives"

# Apply PREFIX to cmake
alias cmake="cmake -DCMAKE_INSTALL_PREFIX=$PREFIX"

# No more YouTube to MP3 sites...
alias yta="youtube-dl --extract-audio --audio-quality 0"

alias dl="aria2c"

alias df="df -h"
alias lc="wc -l"

#alias ixio="curl -F 'f:1=<-' ix.io"
#alias 0x0st="curl -F'file=@$1' 0x0.st"
0x0st () {
	curl -F "file=@$1" 0x0.st
}
ixio () {
	curl -F "f:1=@$1" ix.io
}

# Generate ASCII new-browserhax QR code :)
alias nbhax="ifconfig wlp3s0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/http:\/\/\2\/nbhax.html/p' | qrencode -t asciii -o -"

clipfile () {
	wl-copy -t $(file -b --mime-type "$1") < "$1"
}

ircnick=$USER

alias freenode="sic -h irc.freenode.net -n $ircnick"
alias rizon="sic -h irc.rizon.net -n $ircnick"

alias hexdump="hexdump --color=auto"
alias hack="hexdump -C /dev/urandom | grep 'be ef'"
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias v="$EDITOR"
alias vv="sudo -E $EDITOR" # Preserve enviornment for editor configuration
alias netstat="lsof -i" # Sort of

alias lsbig="du -chsx *(D) 2>/dev/null | sort -rh"
alias dupes="find . ! -empty -type f -exec md5sum {} + | sort | uniq -w32 -dD" # Find duplicates
alias fid="grep -Irn" # Recursively find a pattern in a directory (eg. fid stdio someprojectdir)

alias mnt="udisksctl mount -b"
alias mntftp="curlftpfs"
alias mtp="aft-mtp-mount" 

alias cls="clear"

export BULB="192.168.1.178"

alias yee="yee --effect smooth --auto-on --ip $BULB"
alias bb="yee brightness"
alias bt="yee temperature"
alias bo="yee turn off"
alias bi="yee turn on"

alias pt="pstree -aps"
alias pk="pkill"

alias wth="curl wttr.in"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias gcl="git clone"
alias gcm="git commit"
alias gpl="git pull"
alias gpu="git push"

alias mosh="mosh --no-ssh-pty"

how() { # Extremely useful service (eg. how sed print only matching lines)
	where="$1"; shift
	IFS=+ curl "https://cht.sh/$where/ $*"
} 

# Shorten (effectively remove) insert-normal delay in vi mode
KEYTIMEOUT=1

# Cursor indicators for vi mode: block in normal and i-beam in insert
#		VTE_CURSOR_STYLE_TERMINAL_DEFAULT = 0,
#		VTE_CURSOR_STYLE_BLINK_BLOCK	   = 1,
#		VTE_CURSOR_STYLE_STEADY_BLOCK	   = 2,
#		VTE_CURSOR_STYLE_BLINK_UNDERLINE  = 3,
#		VTE_CURSOR_STYLE_STEADY_UNDERLINE = 4,
#		/* *_IBEAM are xterm extensions */
#		VTE_CURSOR_STYLE_BLINK_IBEAM	   = 5,
#		VTE_CURSOR_STYLE_STEADY_IBEAM	   = 6
function zle-keymap-select zle-line-init {
	case $KEYMAP in
		vicmd)		echo -ne "\e[2 q";; # block cursor for normal
		viins|main) echo -ne "\e[6 q";; # i-beam cursor for insert
	esac
	#zle reset-prompt
	#zle -R
}

zle -N zle-line-init
#zle -N zle-keymap-select
