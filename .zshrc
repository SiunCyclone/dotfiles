case ${OSTYPE} in
  darwin*)
    alias ls="gls --color -v -F";;
  linux*)
    alias ls="ls --color -v -F";;
  msys*)
    alias ls="ls --color -v -F";;
esac
alias lsa="ls -a"
alias lsl="ls -l"
alias lsla="ls -la"
alias lslh="ls -lh"
alias lslah="ls -lah"
alias lslha="ls -lah"
alias .="cd .."
alias gi="git"
alias gil="git l"
alias gila="git la"
alias gilp="git lp"
alias gils="git ls"
alias gilsa="git lsa"
alias gis="git s"
alias giff="git diff"
alias gih="git ch"
alias gib="git b"
alias giba="git ba"
alias gilean="git clean"
alias gimit="git ci -m"
alias gimend="git ci --amend"
alias gibase="git rebase"
alias ginit="git init"
alias gid="git add"
alias gidp="git add -p"
alias ginfig="git config"
alias ginfil="git config --list"
alias ginfiu="git config user.name"
alias ginfim="git config user.email"
alias gish="git push"
alias gill="git pull"
alias gisupdate="git submodule update"
alias gisupdateinit="git submodule update --init"
alias giflog="git reflog"
alias girm="git rm"
alias v="vim"
alias vi="vim"
alias vimp="vim $HOME/.vimperatorrc"
alias vimr="vim $HOME/.vimrc"
alias zshr="vim $HOME/.zshrc"
alias hisz="history -nir 0 | less"
alias df="df -h"

PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export PATH

# Ignore .o file when complete
fignore=(.o)

# Can complete upper-case when typing lower-case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Immedeately ls when using cd
function chpwd() { ls }

# Typo check
setopt correct
# Useful completion
setopt EXTENDED_GLOB
# Remember the directory that cd visit. "cd -[Tab]": Show history
setopt auto_pushd

# Enable using color
autoload colors
colors
# Coloring for tab-completion
autoload -Uz compinit
compinit

export LS_COLORS='di=00;38;05;69:ow=00;38;05;70:*.png=00;38;05;163:*.gif=00;38;05;163:*.jpg=00;38;05;163:*.JPG=00;38;05;163:*.bmp=00;38;05;163:*.html=00;38;05;154:*.cgi=00;38;05;154:*.js=00;38;05;99:*.sh=00;38;05;45:*.rb=00;38;05;166:*.d=00;38;05;220:*.c=00;38;05;190:*.cpp=00;38;05;190:*cc=00;38;05;190:*.h=00;38;05;41:*.css=00;38;05;229:*.avi=00;38;05;205:*.flv=00;38;05;205:*mkv=00;38;05;205:*mp4=00;38;05;205:*.wmv=00;38;05;205:*.rar=00;38;05;124:*.zip=00;38;05;124:*.tar.gz=00;38;05;124:*.mp3=00;38;05;32:*.wav=00;38;05;32:*.m4a=00;38;05;32:*.otf=00;38;05;94:*.ttf=00;38;05;94:*.torrent=00;38;05;34:*.pdf=00;38;05;172'

zstyle ':completion:*' list-colors 'di=00;38;05;69:ow=00;38;05;70:*.png=00;38;05;163:*.gif=00;38;05;163:*.jpg=00;38;05;163:*.JPG=00;38;05;163:*.bmp=00;38;05;163:*.html=00;38;05;154:*.cgi=00;38;05;154:*.js=00;38;05;99:*.sh=00;38;05;45:*.rb=00;38;05;166:*.d=00;38;05;220:*.c=00;38;05;190:*.cpp=00;38;05;190:*cc=00;38;05;190:*.h=00;38;05;41:*.css=00;38;05;229:*.avi=00;38;05;205:*.flv=00;38;05;205:*mkv=00;38;05;205:*mp4=00;38;05;205:*.wmv=00;38;05;205:*.rar=00;38;05;124:*.zip=00;38;05;124:*.tar.gz=00;38;05;124:*.mp3=00;38;05;32:*.wav=00;38;05;32:*.m4a=00;38;05;32:*.otf=00;38;05;94:*.ttf=00;38;05;94:*.torrent=00;38;05;34:*.pdf=00;38;05;172'

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000

# Ignore all duplicate command
setopt hist_ignore_all_dups
# Share the history with other opening shells
setopt share_history
# Doesn't remember a space beginning command
setopt hist_ignore_space
# Record the time
setopt extended_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# Settings of showing git branch
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT="$fg[cyan]${USER}$fg[white]@$fg[magenta]${HOST}$fg[white]     %B%~
%b$ "
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'


# Setup zsh-autosuggestions
#source $HOME/.zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically
#zle-line-init() {
#  zle autosuggest-start
#}

#zle -N zle-line-init

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
#bindkey '^T' autosuggest-toggle

#AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=6'

#bindkey '^H' beginning-of-line
#bindkey '^L' end-of-line

