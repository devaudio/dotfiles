if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ `uname -s` = "Darwin" ]; then
  # homebrew and such
  alias mysqlstart='sudo /opt/local/bin/mysqld_safe5 &'
  alias mysqlstop='/opt/local/bin/mysqladmin5 -u root -p shutdown'
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export PATH=/usr/local/sbin:$PATH
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  source ~/perl5/perlbrew/etc/bashrc
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"
fi
