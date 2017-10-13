set fish_git_dirty_color red
set fish_git_not_dirty_color yellow

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
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

function fish_prompt
  if test -d .git
    printf '%s%s%s:%s$ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s%s%s$ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
end

function marked
  open -a Marked $argv
end

function sfind
  find . -name $argv | grep -v '^\.\/\.git'
end

set -gx EDITOR 'emacs'

set -gx GOPATH $HOME/go
set -gx PATH $HOME/go/bin $PATH

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
alias lan_ip="ifconfig | ruby -e ' puts STDIN.read.scan(/inet ((\d+\.?){4}).*broadcast/).first.first '"
alias ag='ag --color --color-line-number 35 --color-path 34 --color-match 31'
alias psql='psql --host=localhost'
alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"
alias tt='tmuxinator start default'

abbr g 'git'
abbr t 'tmux'
abbr py 'python'
abbr dm 'docker-machine'
abbr b 'bundle'

# Commonly used locations
set -U code ~/code
set -U dotfiles ~/dotfiles
