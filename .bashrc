# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# bash {

  # functions {

    if [ -f ~/.bashrc.functions ]; then
        source ~/.bashrc.functions
    fi

  # }

  # PATH {

    __when_file_exist_do_source $HOME/.bashrc.paths

  # }

  # Alias definitions. {

    # You may want to put all your additions into a separate file like
    # ~/.bashrc.aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.

    __when_file_exist_do_source ~/.bashrc.aliases

  # }

  # Local bash changes {

    # PATH {

      __when_file_exist_do_source ~/.bashrc.paths.local

    # }

    # functions {

      __when_file_exist_do_source $HOME/.bashrc.functions.local

    # }


    # Alias definitions. {

      # You may want to put all your additions into a separate file like
      # ~/.bashrc.aliases, instead of adding them here directly.
      # See /usr/share/doc/bash-doc/examples in the bash-doc package.

      __when_file_exist_do_source $HOME/.bashrc.aliases.local

    # }

    # bashrc {

      __when_file_exist_do_source $HOME/.bashrc.local

    # }

# }

# python {

    # vim-ipython {

        # https://github.com/ivanov/vim-ipython#known-issues
        # http://munkymorgy.blogspot.co.il/2008/07/screen-ctrl-s-bug.html
        # Ctrl-s calls the software flow control method XOFF which stops the character flow to the terminal
        stty stop undef # to unmap ctrl-s

    # }


    # http://saghul.github.io/pythonz/ {

        [[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

    # }

    # pythonz {
        # http://virtualenvwrapper.readthedocs.org/en/latest/
        export WORKON_HOME=~/.pythonz/venvs
        export VIRTUALENVWRAPPER_SCRIPT=$HOME/.local/bin/virtualenvwrapper.sh
        [[ -s $HOME/.local/bin/virtualenvwrapper_lazy.sh ]] && source $HOME/.local/bin/virtualenvwrapper_lazy.sh
        #export PIP_REQUIRE_VIRTUALENV=true
    # }

# }


# tab completion {

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      source /etc/bash_completion
  fi

# }

__when_file_exist_do_source $HOME/liquidprompt/liquidprompt
