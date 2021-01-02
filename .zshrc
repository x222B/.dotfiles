###########
#  ZSHRC  #
###########

# Path to your oh-my-zsh installation
export ZSH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSH="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export ZSH_CUSTOM="$ZSH_CONFIG/custom"


# Load theme 
if [[ "$TERM" != 'linux' ]]; then
    ZSH_THEME='lambda'
fi

# Load plugins
plugins=(
    zsh-syntax-highlighting
    zsh-completions
    zsh-autosuggestions
    command-not-found
    bgnotify
)

# bgnotify settings
bgnotify_threshold=2    ## set your own notification threshold
bgnotify_formatted() {
    ## $1=exit_status, $2=command, $3=elapsed_time
    [[ $1 -eq 0 ]] && title="Zsh" || title="Zsh (fail)"
    bgnotify "$title (${3}s)" "$2"
}


# Remove plugins if in tty
[[ "$TERM" = 'linux' ]] \
    && plugins=("${(@)plugins:#zsh-autosuggestions}")


# Oh-My-Zsh
[[ -f "$ZSH/oh-my-zsh.sh" ]] \
    && source "$ZSH/oh-my-zsh.sh"
    
# profile
[[ -f "$HOME/.config/zsh/zprofile" ]] \
    && source "$HOME/.config/zsh/zprofile"

# eval dircolors
[[ -f "$HOME/.dircolors" ]] \
    && eval "$(dircolors "$HOME/.dircolors")"

# Highlighting
[[ -f "$ZSH_CONFIG/highlight.zsh" ]] \
    && source "$ZSH_CONFIG/highlight.zsh"

# Aliases
[[ -f "$ZSH_CONFIG/alias.zsh" ]] \
    && source "$ZSH_CONFIG/alias.zsh"
    
############
#  CUSTOM  #
############

# History Options
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

unsetopt AUTO_CD
setopt COMPLETE_ALIASES
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST

