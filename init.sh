mv ~/.bash_aliases ~/.bash_aliases.old
mv ~/.bash_profile ~/.bash_profile.old
mv ~/.bashrc ~/.bashrc.old
mv ~/.config/ ~/.config/.old
mv ~/.gitconfig ~/.gitconfig.old
mv ~/.gitignore ~/.gitignore.old
mv ~/.profile ~/.profile.old
mv ~/.tmux.conf ~/.tmux.conf.old

printf "renamed already present files with '.old' postfix\n\n"

mkdir -p ~/.config/sublime-text-3/Packages/User
printf "Sublime Text 3 User folder recreated\n"

ln -s $PWD/.config/sublime-text-3/Packages/User/ ~/.config/sublime-text-3/Packages/User
printf "Symlink created to Sublime Text 3 User folder\n"

ln -s $PWD/.bashrc ~/.bashrc
printf "Symlink created to .bashrc\n"

ln -s $PWD/.bash_aliases ~/.bash_aliases
printf "Symlink created to .bash_aliases\n"

ln -s $PWD/.bash_profile ~/.bash_profile
printf "Symlink created to .bash_profile\n"

ln -s $PWD/.gitconfig ~/.gitconfig
printf "Symlink created to .gitconfig\n"

ln -s $PWD/.gitignore ~/.gitignore
printf "Symlink created to .gitignore\n"

ln -s $PWD/.profile ~/.profile
printf "Symlink created to .profile\n"

ln -s $PWD/.tmux.conf ~/.tmux.conf
printf "Symlink created to .tmux.conf\n\n"
