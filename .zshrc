# The following lines were added by compinstall {{{

zstyle ':completion:*' completer _expand _complete _ignored
zstyle :compinstall filename '/home/dima/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.config/.histfile
HISTSIZE=2048
SAVEHIST=8192
setopt appendhistory autocd extendedglob
unsetopt beep
# End of lines configured by zsh-newuser-install }}}



# Reuse basic config from .bashrc.
source ~/.bashrc

# Completion settings {{{
# Origin: .oh-my-zsh/lib/completion.zsh
WORDCHARS=''

# unsetopt flowcontrol
# setopt auto_menu
# setopt complete_in_word
setopt always_to_end

# bindkey -M menuselect '^o' accept-and-infer-next-history
# Highlight selected menu item
zstyle ':completion:*:*:*:*:*' menu select

# Case sensitive completion
# zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path /home/dima/.zsh/cache

# Set colors for completion
# Origin: .oh-my-zsh/lib/theme-and-appearance.zsh
if [[ -z "$LS_COLORS" ]]; then
  (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# }}}

# Keybindings {{{
# Origin: .oh-my-zsh/lib/key-bindings.zsh
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e                                            # Use emacs key bindings

bindkey '^r' history-incremental-search-backward

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

bindkey "${terminfo[khome]}" beginning-of-line        # [Home] - Go to beginning of line
bindkey "${terminfo[kend]}"  end-of-line              # [End] - Go to end of line

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

bindkey "${terminfo[kcbt]}" reverse-menu-complete     # [Shift-Tab] - move through the completion menu backwards

bindkey "${terminfo[kdch1]}" delete-char              # [Delete] - delete forward
# }}}

# Autosuggestions plugin {{{
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
bindkey '\C-u' autosuggest-accept
# }}}

# Set prompt {{{
# Origins:
# .oh-my-zsh/themes/gentoo.zsh-theme
# https://github.com/Parth/dotfiles/blob/master/zsh/prompt.sh

autoload -U colors && colors
setopt promptsubst

function prompt_char {
    if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

function get_prompt {
    PROMPT=""

    # Username
    CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
    if [ ${CAN_I_RUN_SUDO} -gt 0 ]
    then
        PROMPT="%{$fg_bold[red]%}%n%{$reset_color%} "
    else
        PROMPT="%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n)%{$reset_color%} "
    fi

    # Working directory
    PROMPT+="%{$fg_bold[blue]%}%(!.%1~.%~)%{$reset_color%} "

    # Status code
    PROMPT+="%{$fg_bold[red]%}%(?..%? )%{$reset_color%}"

    # $ / #
    PROMPT+="%{$fg_bold[blue]%}%_$(prompt_char)%{$reset_color%} "
    echo $PROMPT
}

PROMPT="\$(get_prompt)"
# }}}

# Less coloring {{{
export LESS=-R
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$(tput smso; tput setaf 8; tput setab 15; tput bold) # begin reverse video
export LESS_TERMCAP_us=$'\e[01;30m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
# }}}

# vim:fdm=marker:foldlevel=0

