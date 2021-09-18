PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

alias grep='grep --color --exclude-from=$HOME/.grepignore'
alias ag='ag --nobreak --noheading --ignore=tags'
alias tmux='tmux -2'

export USE_CCACHE=1
export CCACHE_DIR=$HOME/.ccache
export LC_ALL="en_US.UTF-8"
export SVN_EDITOR=vim
export _JAVA_OPTIONS=-Xmx7372m
export FZF_DEFAULT_COMMAND="fd --ignore-file $HOME/.fdignore"
export FZF_CTRL_T_COMMAND="fd --type f -u --follow --ignore-file $HOME/.fdignore"
export FZF_ALT_C_COMMAND="fd --type d -u --follow"
