#!/bin/bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
# alias .f='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# [[ "${DEBUG}" == 'true' ]] && \
# alias rsync="rsync --dry-run"

readonly BACKUP_PATH="dotfiles"
readonly BACKUP_FOLDER="Mackup"
readonly DEST_PATH="${HOME}/${BACKUP_PATH}/${BACKUP_FOLDER}"
# {"appname":"adium"}
rsync -av "${HOME}/Library/Preferences/com.adiumX.adiumX.plist" "${DEST_PATH}/Library/Preferences/com.adiumX.adiumX.plist"
rsync -av --delete --exclude 'Users/Default/Logs' "${HOME}/Library/Application Support/Adium 2.0" "${DEST_PATH}/Library/Application Support/Adium 2.0"
#  echo "trash \"${DEST_PATH}/Library/Application Support/Adium 2.0/Users/Default/Logs/\""
exit
# {"appname":"adobe-camera-raw"}
rsync -av "${HOME}/Library/Application Support/Adobe/CameraRaw" "${DEST_PATH}/Library/Application Support/Adobe/CameraRaw"

# {"appname":"atom"}
rsync -av "${HOME}/Library/Preferences/com.github.atom.plist" "${DEST_PATH}/Library/Preferences/com.github.atom.plist"
rsync -av "${HOME}/.atom/snippets.cson" "${DEST_PATH}/.atom/snippets.cson"
rsync -av "${HOME}/.atom/styles.less" "${DEST_PATH}/.atom/styles.less"
rsync -av "${HOME}/.atom/keymap.cson" "${DEST_PATH}/.atom/keymap.cson"
rsync -av "${HOME}/.atom/config.cson" "${DEST_PATH}/.atom/config.cson"
rsync -av "${HOME}/.atom/init.coffee" "${DEST_PATH}/.atom/init.coffee"

# {"appname":"aws"}
rsync -av "${HOME}/.aws" "${DEST_PATH}/.aws"

# {"appname":"bash"}
rsync -av "${HOME}/.profile" "${DEST_PATH}/.profile"
rsync -av "${HOME}/.bash_profile" "${DEST_PATH}/.bash_profile"
rsync -av "${HOME}/.aliases" "${DEST_PATH}/.aliases"

# {"appname":"colorsync"}
rsync -av "${HOME}/Library/ColorSync/Profiles" "${DEST_PATH}/Library/ColorSync/Profiles"

# {"appname":"composer"}
rsync -av "${HOME}/.composer/composer.json" "${DEST_PATH}/.composer/composer.json"

# {"appname":"curl"}
rsync -av "${HOME}/.curlrc" "${DEST_PATH}/.curlrc"

# {"appname":"cyberduck"}
rsync -av "${HOME}/Library/Preferences/ch.sudo.cyberduck.plist" "${DEST_PATH}/Library/Preferences/ch.sudo.cyberduck.plist"

# {"appname":"docker"}
rsync -av "${HOME}/.docker/config.json" "${DEST_PATH}/.docker/config.json"

# {"appname":"dolphin"}
rsync -av "${HOME}/Library/Preferences/org.dolphin-emu.dolphin.plist" "${DEST_PATH}/Library/Preferences/org.dolphin-emu.dolphin.plist"
rsync -av "${HOME}/Library/Application Support/Dolphin" "${DEST_PATH}/Library/Application Support/Dolphin"

# {"appname":"editorconfig"}
rsync -av "${HOME}/.editorconfig" "${DEST_PATH}/.editorconfig"

# {"appname":"flux"}
rsync -av "${HOME}/Library/Preferences/org.herf.Flux.plist" "${DEST_PATH}/Library/Preferences/org.herf.Flux.plist"

# {"appname":"geektool"}
rsync -av "${HOME}/Library/Preferences/org.tynsoe.GeekTool.plist" "${DEST_PATH}/Library/Preferences/org.tynsoe.GeekTool.plist"
rsync -av "${HOME}/Library/Preferences/org.tynsoe.geektool3.plist" "${DEST_PATH}/Library/Preferences/org.tynsoe.geektool3.plist"
rsync -av "${HOME}/Library/Preferences/org.tynsoe.geeklet.shell.plist" "${DEST_PATH}/Library/Preferences/org.tynsoe.geeklet.shell.plist"

# {"appname":"git"}
rsync -av "${HOME}/.gitconfig" "${DEST_PATH}/.gitconfig"

# {"appname":"gitkraken"}
rsync -av "${HOME}/Library/Preferences/com.axosoft.gitkraken.plist" "${DEST_PATH}/Library/Preferences/com.axosoft.gitkraken.plist"
rsync -av "${HOME}/.gitkraken" "${DEST_PATH}/.gitkraken"

# {"appname":"gnupg"}
rsync -av "${HOME}/.gnupg/gpg-agent.conf" "${DEST_PATH}/.gnupg/gpg-agent.conf"
rsync -av "${HOME}/.gnupg/gpg.conf" "${DEST_PATH}/.gnupg/gpg.conf"
rsync -av "${HOME}/.gnupg/trustdb.gpg" "${DEST_PATH}/.gnupg/trustdb.gpg"

# {"appname":"illustrator"}
rsync -av "${HOME}/Library/Preferences/com.adobe.illustrator.plist" "${DEST_PATH}/Library/Preferences/com.adobe.illustrator.plist"
rsync -av "${HOME}/Library/Preferences/Adobe Illustrator 18 Settings" "${DEST_PATH}/Library/Preferences/Adobe Illustrator 18 Settings"
rsync -av "${HOME}/Library/Application Support/Adobe/Adobe Illustrator 18" "${DEST_PATH}/Library/Application Support/Adobe/Adobe Illustrator 18"
rsync -av "${HOME}/Library/Application Support/Adobe/OOBE" "${DEST_PATH}/Library/Application Support/Adobe/OOBE"

# {"appname":"iterm2"}
rsync -av "${HOME}/Library/Preferences/com.googlecode.iterm2.plist" "${DEST_PATH}/Library/Preferences/com.googlecode.iterm2.plist"

# {"appname":"keka"}
rsync -av "${HOME}/Library/Preferences/com.aone.keka.plist" "${DEST_PATH}/Library/Preferences/com.aone.keka.plist"

# {"appname":"macdown"}
rsync -av "${HOME}/Library/Application Support/MacDown/Styles" "${DEST_PATH}/Library/Application Support/MacDown/Styles"
rsync -av "${HOME}/Library/Preferences/com.uranusjr.macdown.plist" "${DEST_PATH}/Library/Preferences/com.uranusjr.macdown.plist"
rsync -av "${HOME}/Library/Application Support/MacDown/Themes" "${DEST_PATH}/Library/Application Support/MacDown/Themes"

# {"appname":"mackup"}
rsync -av "${HOME}/.mackup.cfg" "${DEST_PATH}/.mackup.cfg"

# {"appname":"macosx"}
rsync -av "${HOME}/Library/Workflows" "${DEST_PATH}/Library/Workflows"
rsync -av "${HOME}/Library/Preferences/com.apple.symbolichotkeys.plist" "${DEST_PATH}/Library/Preferences/com.apple.symbolichotkeys.plist"
rsync -av "${HOME}/Library/Services" "${DEST_PATH}/Library/Services"
rsync -av "${HOME}/Library/Scripts" "${DEST_PATH}/Library/Scripts"
rsync -av "${HOME}/Library/PDF Services" "${DEST_PATH}/Library/PDF Services"

# {"appname":"mercurial"}
rsync -av "${HOME}/.hgignore_global" "${DEST_PATH}/.hgignore_global"

# {"appname":"messages"}
rsync -av "${HOME}/Library/Preferences/com.apple.iChat.Jabber.plist" "${DEST_PATH}/Library/Preferences/com.apple.iChat.Jabber.plist"
rsync -av "${HOME}/Library/Preferences/com.apple.iChat.StatusMessages.plist" "${DEST_PATH}/Library/Preferences/com.apple.iChat.StatusMessages.plist"
rsync -av "${HOME}/Library/Preferences/com.apple.iChat.Yahoo.plist" "${DEST_PATH}/Library/Preferences/com.apple.iChat.Yahoo.plist"
rsync -av "${HOME}/Library/Preferences/com.apple.iChat.AIM.plist" "${DEST_PATH}/Library/Preferences/com.apple.iChat.AIM.plist"

# {"appname":"monodevelop"}
rsync -av "${HOME}/Library/Preferences/MonoDevelop-Unity-5.0/MonoDevelopProperties.xml" "${DEST_PATH}/Library/Preferences/MonoDevelop-Unity-5.0/MonoDevelopProperties.xml"

# {"appname":"mou"}
rsync -av "${HOME}/Library/Preferences/com.mouapp.Mou.LSSharedFileList.plist" "${DEST_PATH}/Library/Preferences/com.mouapp.Mou.LSSharedFileList.plist"
rsync -av "${HOME}/Library/Preferences/com.mouapp.Mou.plist" "${DEST_PATH}/Library/Preferences/com.mouapp.Mou.plist"
rsync -av "${HOME}/Library/Application Support/Mou" "${DEST_PATH}/Library/Application Support/Mou"

# {"appname":"mpv"}
rsync -av "${HOME}/.config/mpv/mpv.conf" "${DEST_PATH}/.config/mpv/mpv.conf"
rsync -av "${HOME}/.config/mpv/input.conf" "${DEST_PATH}/.config/mpv/input.conf"

# {"appname":"mysql"}
rsync -av "${HOME}/.my.cnf" "${DEST_PATH}/.my.cnf"

# {"appname":"ngrok"}
rsync -av "${HOME}/.ngrok2" "${DEST_PATH}/.ngrok2"

# {"appname":"npm"}
rsync -av "${HOME}/.npmrc" "${DEST_PATH}/.npmrc"

# {"appname":"oh-my-zsh"}
rsync -av "${HOME}/.oh-my-zsh/custom" "${DEST_PATH}/.oh-my-zsh/custom"

# {"appname":"openemu"}
rsync -av "${HOME}/Library/Preferences/org.openemu.OpenEmu.plist" "${DEST_PATH}/Library/Preferences/org.openemu.OpenEmu.plist"
rsync -av "${HOME}/Library/Application Support/OpenEmu" "${DEST_PATH}/Library/Application Support/OpenEmu"

# {"appname":"photoshop"}
rsync -av "${HOME}/Library/Application Support/Adobe/Adobe Photoshop CC 2015/Presets" "${DEST_PATH}/Library/Application Support/Adobe/Adobe Photoshop CC 2015/Presets"
rsync -av "${HOME}/Library/Preferences/Adobe Photoshop CC 2014 Settings" "${DEST_PATH}/Library/Preferences/Adobe Photoshop CC 2014 Settings"
rsync -av "${HOME}/Library/Application Support/Adobe/Adobe Photoshop CC 2015.5/Presets" "${DEST_PATH}/Library/Application Support/Adobe/Adobe Photoshop CC 2015.5/Presets"
rsync -av "${HOME}/Library/Preferences/Adobe Photoshop CC 2015 Settings" "${DEST_PATH}/Library/Preferences/Adobe Photoshop CC 2015 Settings"
rsync -av "${HOME}/Library/Preferences/Adobe Photoshop CC 2015.5 Settings" "${DEST_PATH}/Library/Preferences/Adobe Photoshop CC 2015.5 Settings"
rsync -av "${HOME}/Library/Preferences/com.adobe.Photoshop.plist" "${DEST_PATH}/Library/Preferences/com.adobe.Photoshop.plist"
rsync -av "${HOME}/Library/Application Support/Adobe/Adobe Photoshop CC 2014/Presets" "${DEST_PATH}/Library/Application Support/Adobe/Adobe Photoshop CC 2014/Presets"

# {"appname":"poedit"}
rsync -av "${HOME}/Library/Preferences/net.poedit.Poedit.plist" "${DEST_PATH}/Library/Preferences/net.poedit.Poedit.plist"
rsync -av "${HOME}/Library/Preferences/net.poedit.Poedit.cfg" "${DEST_PATH}/Library/Preferences/net.poedit.Poedit.cfg"

# {"appname":"quicklook"}
rsync -av "${HOME}/Library/Quicklook" "${DEST_PATH}/Library/Quicklook"

# {"appname":"r"}
rsync -av "${HOME}/.Rhistory" "${DEST_PATH}/.Rhistory"

# {"appname":"rstudio"}
rsync -av "${HOME}/Library/Preferences/org.rstudio.RStudio.plist" "${DEST_PATH}/Library/Preferences/org.rstudio.RStudio.plist"
rsync -av "${HOME}/.rstudio-desktop" "${DEST_PATH}/.rstudio-desktop"

# {"appname":"scripts"}
rsync -av "${HOME}/Library/Scripts" "${DEST_PATH}/Library/Scripts"

# {"appname":"sketch"}
rsync -av "${HOME}/Library/Preferences/com.bohemiancoding.sketch3.plist" "${DEST_PATH}/Library/Preferences/com.bohemiancoding.sketch3.plist"
rsync -av "${HOME}/Library/Application Support/com.bohemiancoding.sketch3" "${DEST_PATH}/Library/Application Support/com.bohemiancoding.sketch3"

# {"appname":"sourcetree"}
rsync -av "${HOME}/Library/Application Support/SourceTree/hgrc_sourcetree" "${DEST_PATH}/Library/Application Support/SourceTree/hgrc_sourcetree"
rsync -av "${HOME}/Library/Application Support/SourceTree/sourcetree.license" "${DEST_PATH}/Library/Application Support/SourceTree/sourcetree.license"
rsync -av "${HOME}/Library/Application Support/SourceTree/hostingservices.plist" "${DEST_PATH}/Library/Application Support/SourceTree/hostingservices.plist"
rsync -av "${HOME}/Library/Application Support/SourceTree/browser.plist" "${DEST_PATH}/Library/Application Support/SourceTree/browser.plist"

# {"appname":"spectacle"}
rsync -av "${HOME}/Library/Application Support/Spectacle" "${DEST_PATH}/Library/Application Support/Spectacle"
rsync -av "${HOME}/Library/Preferences/com.divisiblebyzero.Spectacle.plist" "${DEST_PATH}/Library/Preferences/com.divisiblebyzero.Spectacle.plist"

# {"appname":"spotify"}
rsync -av "${HOME}/Library/Preferences/com.spotify.client.plist" "${DEST_PATH}/Library/Preferences/com.spotify.client.plist"

# {"appname":"spotify-notifications"}
rsync -av "${HOME}/Library/Preferences/io.citruspi.Spotify-Notifications.plist" "${DEST_PATH}/Library/Preferences/io.citruspi.Spotify-Notifications.plist"

# {"appname":"ssh"}
rsync -av "${HOME}/.ssh/config" "${DEST_PATH}/.ssh/config"

# {"appname":"sublime-text-3"}
rsync -av "${HOME}/Library/Application Support/Sublime Text 3/Packages/User" "${DEST_PATH}/Library/Application Support/Sublime Text 3/Packages/User"

# {"appname":"subversion"}
rsync -av "${HOME}/.subversion" "${DEST_PATH}/.subversion"

# {"appname":"terminal"}
rsync -av "${HOME}/Library/Preferences/com.apple.Terminal.plist" "${DEST_PATH}/Library/Preferences/com.apple.Terminal.plist"

# {"appname":"tmux"}
rsync -av "${HOME}/.tmux.conf" "${DEST_PATH}/.tmux.conf"

# {"appname":"vlc"}
rsync -av "${HOME}/Library/Application Support/org.videolan.vlc" "${DEST_PATH}/Library/Application Support/org.videolan.vlc"
rsync -av "${HOME}/Library/Preferences/org.videolan.vlc.plist" "${DEST_PATH}/Library/Preferences/org.videolan.vlc.plist"
rsync -av "${HOME}/Library/Preferences/org.videolan.vlc.LSSharedFileList.plist" "${DEST_PATH}/Library/Preferences/org.videolan.vlc.LSSharedFileList.plist"
rsync -av "${HOME}/Library/Preferences/org.videolan.vlc" "${DEST_PATH}/Library/Preferences/org.videolan.vlc"

# {"appname":"vscode"}
rsync -av "${HOME}/Library/Application Support/Code/User/snippets" "${DEST_PATH}/Library/Application Support/Code/User/snippets"
rsync -av "${HOME}/Library/Application Support/Code/User/settings.json" "${DEST_PATH}/Library/Application Support/Code/User/settings.json"

# {"appname":"whatsapp"}
rsync -av "${HOME}/Library/Application Support/WhatsApp/Preferences" "${DEST_PATH}/Library/Application Support/WhatsApp/Preferences"
rsync -av "${HOME}/Library/Preferences/WhatsApp-Helper.plist" "${DEST_PATH}/Library/Preferences/WhatsApp-Helper.plist"
rsync -av "${HOME}/Library/Preferences/WhatsApp.plist" "${DEST_PATH}/Library/Preferences/WhatsApp.plist"
rsync -av "${HOME}/Library/Application Support/WhatsApp/settings.json" "${DEST_PATH}/Library/Application Support/WhatsApp/settings.json"

# {"appname":"xcode"}
rsync -av "${HOME}/Library/Preferences/com.apple.dt.Xcode.plist" "${DEST_PATH}/Library/Preferences/com.apple.dt.Xcode.plist"
rsync -av "${HOME}/Library/Developer/Xcode/UserData/KeyBindings" "${DEST_PATH}/Library/Developer/Xcode/UserData/KeyBindings"
rsync -av "${HOME}/Library/Application Support/Developer/Shared/Xcode/Plug-ins" "${DEST_PATH}/Library/Application Support/Developer/Shared/Xcode/Plug-ins"

# {"appname":"zsh"}
rsync -av "${HOME}/.zshrc" "${DEST_PATH}/.zshrc"
