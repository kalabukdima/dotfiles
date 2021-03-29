if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi


export LESSHISTFILE="~/.config/.lesshst"
export EDITOR=vim

# Prompt
GREEN="$(tput setaf 2)"
RED="$(tput setaf 1)"
RESET="$(tput sgr0)"
exitstatus()
{
    RETURN=$?
    if [[ ${RETURN} == 0 ]]; then
        echo ""
    else
        echo "$(echo -e \\001)${RED}$(echo -e \\002)${RETURN}"
    fi
}
export PS1="[\[${GREEN}\]\u\[${RESET}\] \w]\$(exitstatus)\$ \[${RESET}\]"

# Aliases
alias l='ls --color=auto -gohAp --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias gdb='gdb -q'
alias py='python3'
alias jn='jupyter notebook'
alias ip='ip -c'
alias tmux='tmux -2'
alias cal='cal -m3'
alias sc='systemctl'
alias rex='pkill xcape ; xcape'
alias packer='packer --noedit'
alias sudo='sudo '
alias watch='watch '
alias bc='bluetoothctl'
alias feh='feh --keep-zoom-vp --scale-down -B black'

# Less coloring
export LESS=-R
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;30m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# Running ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.config/.ssh-agent
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.config/.ssh-agent)" > /dev/null
fi

source ~/config/.bashrc.local
