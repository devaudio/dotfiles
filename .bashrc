# set -x
[ -z "$PS1" ] && return
export MYSQL_PS1="\u@\h [\d]>"
export HISTSIZE=10000                              # bash history will save N commands
export HISTFILESIZE=${HISTSIZE}                    # bash will remember N commands
export HISTCONTROL=ignoreboth                      # ingore duplicates and spaces (ignoreboth, ignoredups, ignorespace)
HISTIGNORE='\&:fg:bg:ls:pwd:cd ..:cd ~-:cd -:cd:jobs:set -x:ls -l:ls -l'
HISTIGNORE=${HISTIGNORE}':%1:%2:shutdown*'
export HISTIGNORE
# you want this for iTerm, or modern versions of secureCrt or putty
shopt -s checkwinsize

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# linux specific - domains , ps and whatever
if [ `uname -s` = "Linux" ]; then
function domaincommand() { dnsdomainname ;}
function subdomaincommand() { domaincommand | awk -F\. {'print $1'} ;}
  if echo hello|grep --color=auto l >/dev/null 2>&1; then
    alias ls='ls --color --dereference-command-line-symlink-to-dir'
    export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
  fi
fi

if [ `uname -s` = "SunOS" ]; then
  # better if avail
  if [ -x /usr/ucb/ps ]; then
    alias ps='/usr/ucb/ps'
  fi

  if [ -x /sw/mysql50/bin/mysql ]; then
  export PATH=/sw/mysql50/bin:$PATH
  fi

  if [ -x /opt/csw/bin/screen ]; then
    alias screen=/opt/csw/bin/screen
  fi

  function domaincommand() { domainname ; }
  function subdomaincommand() { domaincommand | awk -F\. {'print $1'} ;}
  
  if [ "$TERM" != "dumb" ]; then
 	if echo hello|grep --color=auto l >/dev/null 2>&1; then
     alias ls='ls --color --dereference-command-line-symlink-to-dir'
     export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
  	fi
  fi

  if [ -x /sw/bin/vim ]; then
    alias vi='/sw/bin/vim'
  fi

  if [ -x /opt/csw/bin/vim ]; then
    alias vi='/opt/csw/bin/vim'
  fi

fi

if [ `uname -s` = "Darwin" ]; then
  function domaincommand() { cat /etc/resolv.conf | grep domain | awk {'print $2'} |  head -1 ;}
  function subdomaincommand() { domaincommand | awk -F\. {'print $1'} ;}
  # Enable aliases to be sudo’ed
  alias sudo='sudo '
  alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo  gem update'
  # Brew                                                                                                                  
  if [ -x /usr/local/bin/gdircolors ]; then
    alias dircolors='/usr/local/bin/gdircolors'
  fi
    
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH                                                                       
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH=/usr/local/share/man:$MANPATH                                                                           
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

  if [ -x /usr/local/bin/gls ]; then
    alias ls='/usr/local/bin/gls $LS_OPTIONS -h'
    alias ll='/usr/local/bin/gls $LS_OPTIONS -lh'                                                                                         
    alias l='/usr/local/bin/gls $LS_OPTIONS -lAh'
  fi

  alias ssh="ssh -X"

fi


#### end OS specific


alias mroe='more'
alias chmdo='chmod'
alias cls='clear; echo -ne "Currently in .. \033[01;32m${PWD}\033[01;33m:"; echo; ls'
alias sl='ls'

if [ -x /usr/bin/vim ]; then
alias vi='/usr/bin/vim'
fi

if [ -x /usr/local/bin/vim ]; then
alias vi='/usr/local/bin/vim'
fi


# use extract instead of tar/rar/gunzip
extract () {
  if [ -f $1 ] ; then
    case $1 in
          *.tar.bz2)     tar xvjf $1    ;;
          *.tar.gz)      tar xvzf $1    ;;
          *.bz2)         bunzip2 $1     ;;
          *.rar)         rar x $1       ;;
          *.gz)          gunzip $1      ;;
          *.tar)         tar xvf $1     ;;
          *.tbz2)        tar xvjf $1    ;;
          *.zip)         unzip $1       ;;
          *.Z)           uncompress $1  ;;
          *.7z)          7z x $1        ;;
          *)             echo "don't know how to extract '%1'…"
      esac
    else
      echo "'$1' is not a valid file!"
    fi

}


# keychain $HOME/.ssh/old.id_rsa 2>/dev/null
if [ -f /usr/bin/keychain ]; then
    [ -f $HOME/.ssh/id_rsa ] && keychain -q $HOME/.ssh/id_rsa
    [ -f $HOME/.keychain/${HOSTNAME}-sh ] && source ~/.keychain/${HOSTNAME}-sh
fi


# using vi because it's aliased to vim earlier
export EDITOR=vi
export PAGER=less
export LESS=-r
# tab tab included dotfiles
shopt -s dotglob
# spelling errors are corrected if possible
shopt -s cdspell

# append to bash_history for multiple shells instead of glob destroy
shopt -s histappend

bash_prompt() {

    local NONE='\[\033[0m\]'    # unsets color to term's fg color

	# just putting human names on these colors  - nothing else
    # regular colors
    local K='\[\033[0;30m\]'    # black
    local R='\[\033[0;31m\]'    # red
    local G='\[\033[0;32m\]'    # green
    local Y='\[\033[0;33m\]'    # yellow
    local B='\[\033[0;34m\]'    # blue
    local M='\[\033[0;35m\]'    # magenta
    local C='\[\033[0;36m\]'    # cyan
    local W='\[\033[0;37m\]'    # white
    # empahsized (bolded) colors
    local EMK='\[\033[1;30m\]'
    local EMR='\[\033[1;31m\]'
    local EMG='\[\033[1;32m\]'
    local EMY='\[\033[1;33m\]'
    local EMB='\[\033[1;34m\]'
    local EMM='\[\033[1;35m\]'
    local EMC='\[\033[1;36m\]'
    local EMW='\[\033[1;37m\]'
    # background colors
    local BGK='\[\033[40m\]'
    local BGR='\[\033[41m\]'
    local BGG='\[\033[42m\]'
    local BGY='\[\033[43m\]'
    local BGB='\[\033[44m\]'
    local BGM='\[\033[45m\]'
    local BGC='\[\033[46m\]'
    local BGW='\[\033[47m\]'
                                                                
    local UC=$G                 # user's color
        [ $UID -eq "0" ] && UC=$EMR   # root's color

    case $TERM in
     xterm*|rxvt*|ansi*)
         local TITLEBAR='\[\e]0;`subdomaincommand`:\h\a\]'
          ;;
     *)
         local TITLEBAR=""
          ;;
    esac

    PS1="$TITLEBAR${Y}[${UC}\u${B}@${W}\h.${EMY}`subdomaincommand`${EMW}\342\236\224${EMB}\w${Y}]${NONE}"

} 

# are we an interactive shell?
if [ "$PS1" ]; then
    if [ -x /usr/bin/tput ]; then
      if [ "x`tput kbs`" != "x" ]; then # We can't do this with "dumb" terminal
        stty erase `tput kbs`
      fi

    fi

    case $TERM in
      *xterm* | dtterm | *vt100* | *linux* | ansi )
        [ `uname -s` = "SunOS" ] && TERM=ansi || TERM=xterm
	bash_prompt
	unset bash_prompt
        if echo hello|grep --color=auto l >/dev/null 2>&1; then
          export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
        fi

        ;;
      *)
      # we are not on a 'smart color term'
         PS1="\[\e]0;`subdomaincommand`:\h\a\][\u@\h.`domaincommand`\342\236\224\w]"
        ;;
    esac
fi

# erase and kill characters to their default values
stty ek
# useful aliases
alias ducks='du -cks * |sort -rn |head -11'
alias tulip='netstat -tulpn'
export QUOTING_STYLE=literal
