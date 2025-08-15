PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

source /etc/environment

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/depot_tools" ]; then
    PATH="$HOME/.local/depot_tools:$PATH"
fi

if [ -d "$HOME/.bash_completion.d" ]; then
	for bcfile in $HOME/.bash_completion.d/* ; do
		  [ -f "$bcfile" ] && . $bcfile
	done
fi

if [ -f $HOME/.grepignore ]; then
	alias grep='grep --color --exclude-from=$HOME/.grepignore'
else
	alias grep='grep --color'
fi

alias ag='ag --nobreak --noheading --ignore=tags'
alias tmux='tmux -2'

export TERM=screen-256color
export USE_CCACHE=1
export CCACHE_DIR=$HOME/nvme2/.ccache
export LC_ALL="en_US.UTF-8"
export SVN_EDITOR=vim
export _JAVA_OPTIONS=-Xmx7372m
export FZF_DEFAULT_COMMAND="fd --ignore-file $HOME/.fdignore"
export FZF_CTRL_T_COMMAND="fd --type f -u --follow --ignore-file $HOME/.fdignore"
export FZF_ALT_C_COMMAND="fd --type d -d 5 -u --follow"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

function __is_in_git_repo() 
{
    # git rev-parse HEAD > /dev/null 2>&1
    git rev-parse HEAD > /dev/null
}

function fzf-git-co-branch()
{
	if [ "$1" != "" ]; then
		BR="-b $1"
	fi

	git checkout $(git branch | fzf --cycle --border --ansi) $BR
}

function fzf-git-add()
{
	git status --short | fzf --multi --color=dark --cycle --border --ansi --preview-window=up:70% --preview="git diff --color {+2}" | awk '{print $2}'  | xargs git add
}

function fzf-git-log() 
{ 
	# fshow - git commit browser
    __is_in_git_repo || return

    _gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
    _viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always %'"
    git log --oneline --color=always --date=short \
	--format="%C(yellow)%h %C(bold blue)%ad%Creset %<(16)%aN %C(green)%<(80,trunc)%s%Creset" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
	--preview="$_viewGitLogLine" \
	--bind "ctrl-m:execute:
		(grep -o '[a-f0-9]\{7\}' | head -1 |
		xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
		{}
FZF-EOF"
}

function fzf-ag-vim()
{
	local file
	declare -a foo

	file="$(ag --nobreak --noheading $@ | fzf -0 -1 --color=dark --cycle --border --ansi --preview-window=right:50% --preview="mybat {}" )" 

	read -a foo <<< "$(echo $file | awk -F: '{print $1 " " $2}')"

	if [[ -n $file ]]
	then
		vim ${foo[0]} +${foo[1]}
	fi
}

function fzf-vim-file()
{
	file="$(fd $@ | fzf -0 -1 --color=dark --cycle --border --ansi --preview-window=right:50% --preview="bat --style=numbers --color=always {}" )"

	if [[ -n $file ]]; then
		vim $file
	fi
}

function fzf-nvim-file()
{
	file="$(fd $@ | fzf -0 -1 --color=dark --cycle --border --ansi --preview-window=right:50% --preview="bat --style=numbers --color=always {}" )"

	if [[ -n $file ]]; then
		vim $file
	fi
}


#repo forall -c 'GIT_LOG=`git log -5`; echo "#[$REPO_PROJECT]:  $REPO_PATH"; echo "$GIT_LOG"; echo "";'
#repo forall -c 'echo "#[$REPO_PROJECT]: $REPO_PATH";'
