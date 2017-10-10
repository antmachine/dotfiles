# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/anthonysallows/.oh-my-zsh
# export PKG_CONFIG_PATH="/usr/local/Cellar/imagemagick/7.0.4-5/lib/pkgconfig/MagickWand.pc"
# export PKG_CONFIG_PATH="/usr/local/Cellar/imagemagick/7.0.4-5/lib/pkgconfig/MagickWand.pc"
export PATH=/Applications/:$PATH



# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="muse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
 HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(rails chucknorris rake git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# set open file limits to be more than OSX says
ulimit -n 200000
ulimit -u 2048

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
 alias zshconfig="sudo vim ~/.zshrc"
 alias vimconfig="sudo vim ~/.vimrc"
 alias hypconfig="sudo vim ~/.hyper.js"
 alias tmuxconfig="sudo vim ~/.tmux.conf"
 alias gitconfig="sudo vim ~/.gitconfig"
# alias ohmyzsh="mate ~/.oh-my-zsh"

 alias g="git"
 alias zoom="echo 'https://zoom.us/j/3062305118'"
 alias pgup='pg_ctl -D /usr/local/var/postgresql@9.4 start'
 alias pgrestart='pg_ctl restart -D /usr/local/var/postgresql@9.4'
 alias pow="powder"
 alias powenv="ln -s ~/.powenv .powenv"
 alias dbconfcp="cp ~/database.yml config/database.yml"

 alias gitbrahist="git for-each-ref --sort='-committerdate' --format='%(refname)%09%(committerdate)' refs/heads | sed -e 's-refs/heads/--'"

 alias go="git open"
 alias put='git push origin HEAD'
 alias putlab='git push gitlab HEAD'
 alias be="bundle exec"
 alias dbredo="rake db:drop db:create db:schema:load db:migrate db:fixtures:load db:test:prepare"
 alias migstat="rake db:migrate:status"
 alias raketasks="rake -t | less"

 alias prodrc="heroku run rails c --app brivity"
 alias prodlogs="heroku logs --tail --app brivity"

 alias stagerc="heroku run rails c --app brivity-staging"
 alias stagelogs="heroku logs --tail --app brivity-staging"

 alias supportrc="heroku run rails c --app brivity-support"
 alias supportlogs="heroku logs --tail --app brivity-support"

 alias acceptancerc="heroku run rails c --app brivity-acceptance"
 alias acceptancelogs="heroku logs --tail --app brivity-acceptance"

 alias v="vim"
 alias lc='colorls -r'

 alias core="cd ~/brivity-core"
 alias bvs="cd ~/brivity-valuations"
 alias marketing="cd ~/brivity-marketing"
 alias notifications="cd ~/notifications"
 alias cma="cd ~/brivity-cma"

# disable ctrl-s so can save in vim
stty -ixon

# show the git status and file contents when cd to a directory
function chpwd() {
  if [[ -a .git  ]]; then
    git fetch && git status
  fi
  ls -a
}

# make a dir and cd into it
function mkcdir ()
{
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

# entertain and enlighten
echo "antmachine" | figlet | lolcat
fortune | cowsay

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# Functions
#

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch() {
  git_current_branch
}
# The list of remotes
function current_repository() {
  if ! $_omz_git_git_cmd rev-parse --is-inside-work-tree &> /dev/null; then
    return
  fi
    echo $($_omz_git_git_cmd remote -v | cut -d':' -f 2)
}
# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1  ]; then
    git log --pretty=$1
  fi
}
# Warn if the current branch is a WIP
function work_in_progress() {
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then
    echo "WIP!!"
  fi
}

export NVM_DIR="/Users/anthonysallows/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/elasticsearch@2.4/bin:$PATH"
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"
