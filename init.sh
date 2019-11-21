mv ~/.bash_aliases ~/.bash_aliases.old
mv ~/.bash_profile ~/.bash_profile.old
mv ~/.bashrc ~/.bashrc.old
mv ~/.gitconfig ~/.gitconfig.old
mv ~/.gitignore ~/.gitignore.old
mv ~/.profile ~/.profile.old
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.inputrc ~/.inputrc.old
mv ~/.tern-project ~/.tern-project.old
printf "    renamed already present files with '.old' postfix\n"

ln -s $PWD/.bashrc ~/.bashrc
printf "    Symlink created to .bashrc\n"
ln -s $PWD/.bash_aliases ~/.bash_aliases
printf "    Symlink created to .bash_aliases\n"
ln -s $PWD/.bash_profile ~/.bash_profile
printf "    Symlink created to .bash_profile\n"
ln -s $PWD/.gitconfig ~/.gitconfig
printf "    Symlink created to .gitconfig\n"
ln -s $PWD/.gitignore ~/.gitignore
printf "    Symlink created to .gitignore\n"
ln -s $PWD/.profile ~/.profile
printf "    Symlink created to .profile\n"
ln -s $PWD/.tmux.conf ~/.tmux.conf
printf "    Symlink created to .tmux.conf\n"
ln -s $PWD/.inputrc ~/.inputrc
printf "    Symlink created to .inputrc\n"
ln -s $PWD/.tern-project ~/.tern-project
printf "    Symlink created to .tern-project\n\n"

cat code-extensions.txt | xargs -L 1 code --install-extension
printf "    installed vscode extensions from code-extensions.txt\n"
code --list-extensions > code-extensions.txt
printf "    saved currently installed VScode extensions in code-extensions.txt\n\n"
