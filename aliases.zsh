# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias weather="curl -4 http://wttr.in"
alias zshconfig="nvim ~/.dotfiles/.zshrc"
alias ngrok="$HOME/ngrok"

# Directories
alias dotfiles="cd $DOTFILES"
alias projects="cd $HOME/Documents/Projects"
alias personal="cd $HOME/Documents/Personal-projects"

# use nvim, but don't make me think about it
alias vim="nvim"

# Filesystem aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Laravel
alias art="php artisan"

# Vagrant
alias v="vagrant global-status"
alias vup="vagrant up"
alias vhalt="vagrant halt"
alias vssh="vagrant ssh"
alias vreload="vagrant reload"
alias vrebuild="vagrant destroy --force && vagrant up"

