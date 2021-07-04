#
## Oh My Zsh History excerpt (with some changes)
#
#

HISTFILE="$HOME/.zsh_history"

HISTSIZE=15000
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
	[ -e ~/.cache/wal/colors-tty.sh ] && source ~/.cache/wal/colors-tty.sh

	# Replace caps with escape (requires you to setuid the loadkeys binary)
	loadkeys <<<"keycode 58 = Escape"

	# Hotfix
	true
} || {
	[ -e ~/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &) # Set wal colors, you may not want this on terminals that already have wal includes as I've had it break background transparency before on urxvt

	# Lazy powerlevel9k legacy variables (pl11k eat wen)
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
zle -N zle-keymap-select

source ~/.aliasrc
