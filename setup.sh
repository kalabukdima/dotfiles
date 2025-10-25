git submodule update --init --recursive

ln -sfv ~/config/.bashrc ~
touch ~/config/.bashrc.local

ln -sfv ~/config/.zshrc ~
touch ~/config/.zshrc.local

ln -sfv ~/config/.tmux.conf ~
touch ~/config/.tmux.conf.local

ln -sfv ~/config/.gitconfig ~

ln -sfv ~/config/.p10k.zsh ~

mkdir -p ~/.config
ln -sfv ~/config/ranger/ ~/.config/

ln -sfv ~/config/openbox/ ~/.config/

chsh -s /usr/bin/zsh

sudo ln -sfv ~/config/xorg.conf.d/* /etc/X11/xorg.conf.d/

sudo mkdir -p /usr/share/kbd/keymaps/i386/workman
sudo cp -v kbd/keymaps/i386/workman/* /usr/share/kbd/keymaps/i386/workman/
sudo cp -v kbd/keymaps/i386/include/workman-layout.inc /usr/share/kbd/keymaps/i386/include
