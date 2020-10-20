del %userprofile%\*.old
del %userprofile%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json.old

del %userprofile%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json.old
ren %userprofile%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json settings.json.old

ren %userprofile%\.babel.json   .babel.json.old
ren %userprofile%\.bash_aliases .bash_aliases.old
ren %userprofile%\.bash_profile .bash_profile.old
ren %userprofile%\.bashrc       .bashrc.old
ren %userprofile%\.eslintrc.js  .eslintrc.js.old
ren %userprofile%\.gitconfig    .gitconfig.old
ren %userprofile%\.gitignore    .gitignore.old
ren %userprofile%\.inputrc      .inputrc.old
ren %userprofile%\.npmrc        .npmrc.old
ren %userprofile%\.profile      .profile.old
ren %userprofile%\.tern-project .tern-project.old
ren %userprofile%\.tmux.conf    .tmux.conf.old

echo "renamed already present files with '.old' postfix\n"

mklink %userprofile%\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json %cd%\settings.json
mklink %userprofile%\.babel.json   %cd%\.babel.json
mklink %userprofile%\.bash_aliases %cd%\.bash_aliases
mklink %userprofile%\.bash_profile %cd%\.bash_profile
mklink %userprofile%\.bashrc       %cd%\.bashrc
mklink %userprofile%\.eslintrc.js  %cd%\.eslintrc.js
mklink %userprofile%\.gitconfig    %cd%\.gitconfig
mklink %userprofile%\.gitignore    %cd%\.gitignore
mklink %userprofile%\.inputrc      %cd%\.inputrc
mklink %userprofile%\.npmrc        %cd%\.npmrc
mklink %userprofile%\.profile      %cd%\.profile
mklink %userprofile%\.tern-project %cd%\.tern-project
mklink %userprofile%\.tmux.conf    %cd%\.tmux.conf
