mv ~/.bash_aliases ~/.bash_aliases.old
mv ~/.bash_profile ~/.bash_profile.old
mv ~/.bashrc ~/.bashrc.old
mv ~/.config/ ~/.config/.old
mv ~/.gitconfig ~/.gitconfig.old
mv ~/.gitignore ~/.gitignore.old
mv ~/.profile ~/.profile.old
mv ~/.tmux.conf ~/.tmux.conf.old

mkdir -p ~/.config/sublime-text-3/Packages/User

ln -s $PWD/.config/sublime-text-3/Packages/User/ ~/.config/sublime-text-3/Packages/User
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.bash_aliases ~/.bash_aliases
ln -s $PWD/.bash_profile ~/.bash_profile
ln -s $PWD/.gitconfig ~/.gitconfig
ln -s $PWD/.gitignore ~/.gitignore
ln -s $PWD/.profile ~/.profile
ln -s $PWD/.tmux.conf ~/.tmux.conf
