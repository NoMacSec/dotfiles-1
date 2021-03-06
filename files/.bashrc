# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# setup nvim aliases
if command -v nvim>/dev/null; then
  alias vi="/usr/bin/nvim"
  alias vim="/usr/bin/nvim"
fi

# start powerline-daemon if it exists, needed for tmux
if command -v powerline>/dev/null; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . ~/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
fi

# setup powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}
if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# auto-start tmux
function start_tmux() {
    if type tmux &> /dev/null; then
        #if not inside a tmux session, and if no session is started, start a new session
        if [[ -z "$TMUX" && -z $TERMINAL_CONTEXT ]]; then
            (tmux -2 attach || tmux -2 new-session)
        fi
    fi
}
start_tmux
