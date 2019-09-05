# Debug
#zmodload zsh/zprof

##########################################################################################

###########
#  ZSHRC  #
###########

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Path to your oh-my-zsh installation

export ZSH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
#export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH_CONFIG/custom"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

if [[ "$TERM" != 'linux' ]]; then
    ZSH_THEME='norm'
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )


#############
#  PROFILE  #
#############

[[ -f "$HOME/.zprofile" ]] \
    && source "$HOME/.zprofile"


###############
#  DIRCOLORS  #
###############

# eval dircolors
[[ -f "$HOME/.dircolors" ]] \
    && eval "$(dircolors "$HOME/.dircolors")"


#####################
#  PLUGIN SETTINGS  #
#####################

# bgnotify settings
bgnotify_threshold=2    ## set your own notification threshold
bgnotify_formatted() {
    ## $1=exit_status, $2=command, $3=elapsed_time
    [[ $1 -eq 0 ]] && title="Zsh" || title="Zsh (fail)"
    bgnotify "$title (${3}s)" "$2"
}

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-syntax-highlighting
    zsh-completions
    zsh-autosuggestions
    command-not-found
    bgnotify
)

# # Native plugins
# plugins=(
#     command-not-found
#     colorize
#     bgnotify
# )
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Remove plugins if in tty
[[ "$TERM" = 'linux' ]] \
    && plugins=("${(@)plugins:#zsh-autosuggestions}")

# Completions
[[ -f "$ZSH_CONFIG/completion.zsh" ]] \
    && source "$ZSH_CONFIG/completion.zsh"

# Oh-My-Zsh
[[ -f "$ZSH/oh-my-zsh.sh" ]] \
    && source "$ZSH/oh-my-zsh.sh"


########################
#  USER CONFIGURATION  #
########################

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#     export EDITOR='vim'
# else
#     export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="$HOME/.ssh/rsa_id"


############
#  CUSTOM  #
############

# Zsh options
setopt COMPLETE_ALIASES
setopt HIST_IGNORE_SPACE
setopt NO_AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST


# No scrolllock
stty -ixon


# Highlighting
[[ -f "$ZSH_CONFIG/highlight.zsh" ]] \
    && source "$ZSH_CONFIG/highlight.zsh"


# Aliases
[[ -f "$ZSH_CONFIG/alias.zsh" ]] \
    && source "$ZSH_CONFIG/alias.zsh"


# Gruvbox colors fix
[[ -f "$HOME/.bin/fix-gruvbox-palette" ]] \
    && [[ "$TERM" != 'xterm-kitty' ]] \
    && [[ "$TERM" != 'tmux-256color' ]] \
    && source "$HOME/.bin/fix-gruvbox-palette"


# Empty line
#function echo_blank() {
#    echo
#}
#precmd_functions+=echo_blank
#preexec_functions+=echo_blank

# Kitty completion
source <(kitty + complete setup zsh)


##########################################################################################

# Debug
#zprof
