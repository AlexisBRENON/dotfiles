#! /bin/sh

alias g='git'

alias ga='git add'
alias gap='git add --patch'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'

alias gbl='git blame -b -w'

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcaam='git commit -v -a --amend'
alias gcaamn='git commit -v -a --no-edit --amend'
alias gcam='git commit -v --amend'
alias gcamn='git commit -v --no-edit --amend'
alias gcaamns='git commit -v -a -s --no-edit --amend'
alias gcmsg='git commit -m'
alias gcamsg='git commit -a -m'

alias gcl='git clone --recursive'

alias gclean='git clean -fd'

alias gcm='git checkout master'
alias gco='git checkout'
alias gcob='git checkout -b'

alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

alias gd='git diff'
alias gdw='git diff --word-diff'

alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'

gls() { git ls-files | grep "$@" ; }

#alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'

alias ghh='git help'

alias gl='git pull'
alias glr='git pull --rebase'


alias glg='git log --oneline --decorate --graph'
alias glgs='glg --stat'
alias glga='glg --all'
alias glog='git log --abbrev-commit --decorate --graph --format='\''%C(yellow)%h%C(reset) %C(blue)%ai%C(reset) %C(auto)%d%C(reset)%n%C(white)%w(72,4,4)%s%C(reset)'\'
alias gloga='glog --all'

alias gm='git merge'

alias gp='git push'
alias gpall='git push origin --all && git push origin --tags'
alias gpu='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gpv='git push -v'

alias grb='git rebase'
alias grbi='git rebase -i'
alias grbp='git rebase -p'
alias grbip='git rebase -ip'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'

alias grst='git reset'
alias grsth='git reset HEAD'
alias grsthh='git reset HEAD --hard'

alias gst='git status'

alias gsta='git stash save'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'

alias gsmi='git submodule sync --recursive && git submodule update --init --recursive'
alias gsmu='git submodule update'

alias gts='git tag -s'
alias gtv='git tag | sort -V'

alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
alias gbackup='gwip && git push origin HEAD:backup-$(date -I) && gunwip'

