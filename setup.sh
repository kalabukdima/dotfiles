ln -sf ~/config/.bashrc ~
touch ~/config/.bashrc.local

ln -sf ~/config/.zshrc ~
touch ~/config/.zshrc.local

ln -sf ~/config/.tmux.conf ~
touch ~/config/.tmux.conf.local

ln -sf ~/config/.gitconfig ~

mkdir -p ~/.config
ln -sf ~/config/ranger/ ~/.config/
