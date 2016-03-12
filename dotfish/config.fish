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
  if contains $_ "fish"
    pwd | sed 's!'"$HOME"'!~!g'
  else
    echo $_
  end
end

function fish_prompt
  if test -d .git
    printf '%s%s%s:%s$ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s%s%s$ ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
end

function ze
  zeus $argv
  set exit_code $status
  stty sane
  if test $exit_code = 2
    ze $argv
  end
end

set -gx EDITOR 'emacs'

set -gx PATH ~/bin ~/.cl/bin /usr/local/bin $PATH
set -gx PATH $HOME/.cask/bin $PATH
set -gx PATH $HOME/google-cloud-sdk/bin $PATH
set -gx PATH $HOME/Dropbox/code/clarity/clarity/bin $PATH

# Custome slimerjs build...
set -gx PATH $HOME/Downloads/slimerjs-RELEASE_0.9.6/src $PATH
set -gx SLIMERJSLAUNCHER /Applications/Firefox.app/Contents/MacOS/firefox

set -gx PATH $HOME/code/smartprs/bin $PATH

set -gx PATH $HOME/.rbenv/bin $PATH
rbenv init - | source


set -gx GOPATH $HOME/go
set -gx PATH $HOME/go/bin $PATH

alias grep='grep --color'

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -A'
alias lrt='ls -lrt'
alias l1='ls -1'
alias cls='clear'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias du0='du -h --max-depth=0'

# expands "g+<space>" and "g+<enter>" to "git". This fixes
# the problem with completions not working with aliases until
# the real --wraps behaviour lands in the brew version.
alias g='git'
set -U fish_user_abbreviations

abbr g 'git'
abbr t 'tmux'
abbr z 'zeus'
abbr py 'python'
abbr dm 'docker-machine'

alias ios="open /Applications/Xcode.app/Contents/Applications/iOS\ Simulator.app/"

alias lan_ip="ifconfig | ruby -e ' puts STDIN.read.scan(/inet ((\d+\.?){4}).*broadcast/).first.first '"

alias fact="elinks -dump randomfunfacts.com | sed -n '/^| /p' | tr -d \|"

# alias tunnel='autossh -M 10030 -f -N -R :3003:localhost:3000 vince@legacy-staging.clarity.fm'
alias tunnel='ssh -R :3003:localhost:3000 vince@legacy-staging.clarity.fm'

alias ag='ag --color --color-line-number 35 --color-path 34 --color-match 31'

alias psql='psql --host=localhost'

alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"

function marked
         open -a Marked $argv
end
