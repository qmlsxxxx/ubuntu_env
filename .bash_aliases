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


function __is_in_git_repo() 
{
    # git rev-parse HEAD > /dev/null 2>&1
    git rev-parse HEAD > /dev/null
}

function __fzf_git_co_branch()
{
	if [ "$1" != "" ]; then
		BR="-b $1"
	fi

	git checkout $(git branch | fzf --cycle --border --ansi) $BR
}

function __fzf_git_add()
{
	git status --short | fzf --multi --color=dark --cycle --border --ansi --preview-window=up:70% --preview="git diff --color {+2}" | awk '{print \$2}'  | xargs git add
}

function __fzf_git_log() 
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

function __fzf_ag_vim()
{
	local file
	declare -a foo

	file="$(ag --nobreak --noheading "$1" | awk -F: '{print $1 ":" $2}' | fzf -0 -1 --color=dark --cycle --border --ansi --preview-window=right:50% --preview="mybat {}" )" 

	read -a foo <<< "$(echo $file | awk -F: '{print $1 " " $2}')"

	if [[ -n $file ]]
	then
		vim ${foo[0]} +${foo[1]}
	fi
}

function __fzf_vim_file()
{
	file="$(fd $1 | fzf -0 -1 --color=dark --cycle --border --ansi --preview-window=right:50% --preview="bat --style=numbers --color=always {}" )"

	if [[ -n $file ]]; then
		vim $file
	fi
}


