mv ~/.bash_aliases ~/.bash_aliases.old
mv ~/.bash_profile ~/.bash_profile.old
mv ~/.bashrc ~/.bashrc.old
mv ~/.config/ ~/.config/.old
mv ~/.gitconfig ~/.gitconfig.old
mv ~/.gitignore ~/.gitignore.old
mv ~/.profile ~/.profile.old
mv ~/.tmux.conf ~/.tmux.conf.old

print "renamed already present files with '.old' postfix"

mkdir -p ~/.config/sublime-text-3/Packages/User
print "Sublime Text 3 User folder recreated"

ln -s $PWD/.config/sublime-text-3/Packages/User/ ~/.config/sublime-text-3/Packages/User
print "Symlink created to Sublime Text 3 User folder"

ln -s $PWD/.bashrc ~/.bashrc
print "Symlink created to .bashrc"

ln -s $PWD/.bash_aliases ~/.bash_aliases
print "Symlink created to .bash_aliases"

ln -s $PWD/.bash_profile ~/.bash_profile
print "Symlink created to .bash_profile"

ln -s $PWD/.gitconfig ~/.gitconfig
print "Symlink created to .gitconfig"

ln -s $PWD/.gitignore ~/.gitignore
print "Symlink created to .gitignore"

ln -s $PWD/.profile ~/.profile
print "Symlink created to .profile"

ln -s $PWD/.tmux.conf ~/.tmux.conf
print "Symlink created to .tmux.conf"
