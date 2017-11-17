set fish_git_dirty_color red
set fish_git_not_dirty_color yellow

function parse_git_branch
  set -l branch (git rev-parse --abbrev-ref HEAD)
  set -l git_diff (git diff)

  if test -n "$git_diff"
    echo (set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
end

function fish_title
  prompt_pwd
end

function fish_greeting
  # Disable greeting
end

function __format_time -d "Format milliseconds to a human readable format"
  set -l milliseconds $argv[1]
  set -l seconds (math "$milliseconds / 1000 % 60")
  set -l minutes (math "$milliseconds / 60000 % 60")
  set -l hours (math "$milliseconds / 3600000 % 24")
  set -l days (math "$milliseconds / 86400000")
  set -l time
  set -l threshold $argv[2]

  if test $days -gt 0
    set time (command printf "$time%sd " $days)
  end

  if test $hours -gt 0
    set time (command printf "$time%sh " $hours)
  end

  if test $minutes -gt 0
    set time (command printf "$time%sm " $minutes)
  end

  if test $seconds -gt $threshold
    set time (command printf "$time%ss " $seconds)
  end

  echo -e $time
end

function _prompt_color_for_status
  if test $argv[1] -eq 0
    echo magenta
  else
    echo red
  end
end

function fish_prompt
  set -l last_status $status

  if test $CMD_DURATION
    set command_duration (__format_time $CMD_DURATION 5)
    if test $command_duration
      printf "\n%s~ $command_duration\n" (set_color red)
    end
  end

  if test -d .git
    # printf '%s%s%s:%s$ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
    printf '%s%s %s%s\n❯ ' (set_color $fish_color_cwd) (prompt_pwd) (parse_git_branch) (set_color (_prompt_color_for_status $last_status))
  else
    # printf '%s%s%s$ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
    printf '%s%s%s\n❯ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color (_prompt_color_for_status $last_status))
  end
end

function marked
  open -a Marked $argv
end

function sfind
  find . -name $argv | grep -v '^\.\/\.git'
end

# Configure symnav to support symlink navigation in fish (without expansion).
# https://github.com/externl/fish-symnav
function fish_user_key_bindings
  bind -M default \t '__symnav_complete'
  bind -M default \r '__symnav_execute'
  bind -M default \n '__symnav_execute'
end
set symnav_execute_substitution 1

set -gx EDITOR 'emacs -nw'

set -gx GOPATH $HOME/go
set -gx PATH $GOBIN $PATH
set -gx GOBIN $GOPATH/bin
set -gx PATH $HOME/bin $PATH
set -gx PATH $HOME/code/tools $PATH

set -gx JARVIS_USERNAME vincentroy

set -gx DOCKER_GROUP_ID 50

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -A'
alias lrt='ls -lrt'
alias l1='ls -1'
alias cls='clear'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color'
alias du0='du -h --max-depth=0'
alias g='git'
alias ios="open /Applications/Xcode.app/Contents/Applications/iOS\ Simulator.app/"
# alias lan_ip="ifconfig | ruby -e ' puts STDIN.read.scan(/inet ((\d+\.?){4}).*broadcast/).first.first '"
alias ag='ag --color --color-line-number 35 --color-path 34 --color-match 31'
alias psql='psql --host=localhost'
alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"
alias tt='tmuxinator start default'
alias e='emacsclient -nw'
alias emacs='emacs -nw'
alias ij='open *.ipr'
alias zk='zookeepercli --servers=localhost -c'

set -U fish_user_abbreviations

abbr g 'git'
abbr t 'tmux'
abbr py 'python'
abbr dm 'docker-machine'
abbr b 'bundle'
abbr j 'jarvis'
abbr mux 'tmuxinator'

# Commonly used locations
set -U platform ~/nautilus/platform
set -U ci ~/nautilus/platform/ci
set -U code ~/code
set -U caspian ~/caspian
set -U jarvis ~/nautilus/platform/jarvis

set -U dotfiles ~/dotfiles
set -U nautilus ~/nautilus
set -U pravega ~/nautilus/pravega
set -U analytics ~/nautilus/analytics
set -U adminrouter ~/nautilus/dcos/packages/adminrouter/extra/src
set -U dcos ~/nautilus/dcos