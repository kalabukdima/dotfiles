ln -sfv ~/config/.bashrc ~
touch ~/config/.bashrc.local

ln -sfv ~/config/.zshrc ~
touch ~/config/.zshrc.local

ln -sfv ~/config/.tmux.conf ~
touch ~/config/.tmux.conf.local

ln -sfv ~/config/.gitconfig ~

mkdir -p ~/.config
ln -sfv ~/config/ranger/ ~/.config/

ln -sfv ~/config/openbox/ ~/.config/

sudo -n mkdir -p /usr/share/kbd/keymaps/i386/workman
sudo -n cp -v kbd/keymaps/i386/workman/* /usr/share/kbd/keymaps/i386/workman/
sudo -n cp -v kbd/keymaps/i386/include/workman-layout.inc /usr/share/kbd/keymaps/i386/include
