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
alias lslh="ls -lh"
alias lsla="ls -l -a"
alias .="cd .."
alias v="vim"
alias vi="vim"

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
autoload -U compinit
compinit

export LS_COLORS='di=01;38;05;69:ow=01;38;05;70:*.png=00;38;05;163:*.gif=00;38;05;163:*.jpg=00;38;05;163:*.JPG=00;38;05;163:*.bmp=00;38;05;163:*.html=00;38;05;154:*.cgi=00;38;05;154:*.js=00;38;05;99:*.sh=00;38;05;45:*.rb=00;38;05;166:*.d=00;38;05;220:*.c=00;38;05;190:*.cpp=00;38;05;190:*cc=00;38;05;190:*.h=00;38;05;41:*.css=00;38;05;229:*.avi=00;38;05;205:*.flv=00;38;05;205:*mkv=00;38;05;205:*mp4=00;38;05;205:*.wmv=00;38;05;205:*.rar=00;38;05;124:*.zip=00;38;05;124:*.tar.gz=00;38;05;124:*.mp3=00;38;05;32:*.wav=00;38;05;32:*.m4a=00;38;05;32:*.otf=00;38;05;94:*.ttf=00;38;05;94:*.torrent=00;38;05;34:*.pdf=00;38;05;172'

zstyle ':completion:*' list-colors 'di=01;38;05;69:ow=01;38;05;70:*.png=00;38;05;163:*.gif=00;38;05;163:*.jpg=00;38;05;163:*.JPG=00;38;05;163:*.bmp=00;38;05;163:*.html=00;38;05;154:*.cgi=00;38;05;154:*.js=00;38;05;99:*.sh=00;38;05;45:*.rb=00;38;05;166:*.d=00;38;05;220:*.c=00;38;05;190:*.cpp=00;38;05;190:*cc=00;38;05;190:*.h=00;38;05;41:*.css=00;38;05;229:*.avi=00;38;05;205:*.flv=00;38;05;205:*mkv=00;38;05;205:*mp4=00;38;05;205:*.wmv=00;38;05;205:*.rar=00;38;05;124:*.zip=00;38;05;124:*.tar.gz=00;38;05;124:*.mp3=00;38;05;32:*.wav=00;38;05;32:*.m4a=00;38;05;32:*.otf=00;38;05;94:*.ttf=00;38;05;94:*.torrent=00;38;05;34:*.pdf=00;38;05;172'

PROMPT="$fg[cyan]${USER}$fg[white]@$fg[magenta]${HOST}$fg[white]$fg[white]     %B%~
%b$ "
RPROMPT="%B[%35<..<%~]"

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

