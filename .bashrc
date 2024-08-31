#
# ~/.bashrc
#

# If not running interactively, don't do anything
set -o vi
[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
#alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export TERM=tmux-256color
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# [ -z "$TMUX" ] && tmux

# Get a list of all available tmux sessions
tmux_sessions=$(tmux list-sessions -F "#S" | sort -n)

# Flag to track if we found an unattached session
attached=0

# Loop through the sessions
for session in $tmux_sessions; do
  # Check if the session is attached (contains an attached indicator)
  if tmux list-sessions | grep -q "$session:.*attached"; then
    continue
  else
    # Attach to the first unattached session and set the flag
    tmux attach -t "$session"
    attached=1
    break
  fi
done

# If no unattached sessions were found, create a new one
if [ $attached -eq 0 ]; then
  tmux new-session
fi


export PATH="$PATH:$HOME/bin"
alias lg='lazygit'
# alias n='NVIM_APPNAME="nvim-kickstart" nvim'
alias n='nvim'
alias a='tmux attach'
alias ..='cd ..'
alias dkr='sudo systemctl start docker.service'

# nvimk() {
#   NVIM_APPNAME="nvim-kickstart" nvim "$@"
# }
export PATH="$PATH:/home/boss/.foundry/bin"

