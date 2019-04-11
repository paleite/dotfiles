#!/usr/bin/env bash

[[ "${DEBUG}" == 'true' ]] && set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

shopt -s expand_aliases
alias grep='grep --color=always'

readonly QUERY="$1"
readonly LOCATIONS=( \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.adiumX.adiumX.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Adium 2.0" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Adobe/CameraRaw" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.github.atom.plist" \
"${HOME}/dotfiles/Mackup/.atom/snippets.cson" \
"${HOME}/dotfiles/Mackup/.atom/styles.less" \
"${HOME}/dotfiles/Mackup/.atom/keymap.cson" \
"${HOME}/dotfiles/Mackup/.atom/config.cson" \
"${HOME}/dotfiles/Mackup/.atom/init.coffee" \
"${HOME}/dotfiles/Mackup/.aws" \
"${HOME}/dotfiles/Mackup/.profile" \
"${HOME}/dotfiles/Mackup/.bash_profile" \
"${HOME}/dotfiles/Mackup/.aliases" \
"${HOME}/dotfiles/Mackup/Library/ColorSync/Profiles" \
"${HOME}/dotfiles/Mackup/.composer/composer.json" \
"${HOME}/dotfiles/Mackup/.curlrc" \
"${HOME}/dotfiles/Mackup/Library/Preferences/ch.sudo.cyberduck.plist" \
"${HOME}/dotfiles/Mackup/.docker/config.json" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.dolphin-emu.dolphin.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Dolphin" \
"${HOME}/dotfiles/Mackup/.editorconfig" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.herf.Flux.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.tynsoe.GeekTool.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.tynsoe.geektool3.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.tynsoe.geeklet.shell.plist" \
"${HOME}/dotfiles/Mackup/.gitconfig" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.axosoft.gitkraken.plist" \
"${HOME}/dotfiles/Mackup/.gitkraken" \
"${HOME}/dotfiles/Mackup/.gnupg/gpg-agent.conf" \
"${HOME}/dotfiles/Mackup/.gnupg/gpg.conf" \
"${HOME}/dotfiles/Mackup/.gnupg/trustdb.gpg" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.adobe.illustrator.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/Adobe Illustrator 18 Settings" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Adobe/Adobe Illustrator 18" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Adobe/OOBE" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.googlecode.iterm2.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.aone.keka.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/MacDown/Styles" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.uranusjr.macdown.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/MacDown/Themes" \
"${HOME}/dotfiles/Mackup/.mackup.cfg" \
"${HOME}/dotfiles/Mackup/Library/Workflows" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.apple.symbolichotkeys.plist" \
"${HOME}/dotfiles/Mackup/Library/Services" \
"${HOME}/dotfiles/Mackup/Library/Scripts" \
"${HOME}/dotfiles/Mackup/Library/PDF Services" \
"${HOME}/dotfiles/Mackup/.hgignore_global" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.apple.iChat.Jabber.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.apple.iChat.StatusMessages.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.apple.iChat.Yahoo.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.apple.iChat.AIM.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/MonoDevelop-Unity-5.0/MonoDevelopProperties.xml" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.mouapp.Mou.LSSharedFileList.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.mouapp.Mou.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Mou" \
"${HOME}/dotfiles/Mackup/.config/mpv/mpv.conf" \
"${HOME}/dotfiles/Mackup/.config/mpv/input.conf" \
"${HOME}/dotfiles/Mackup/.my.cnf" \
"${HOME}/dotfiles/Mackup/.ngrok2" \
"${HOME}/dotfiles/Mackup/.npmrc" \
"${HOME}/dotfiles/Mackup/.oh-my-zsh/custom" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.openemu.OpenEmu.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/OpenEmu" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Adobe/Adobe Photoshop CC 2015/Presets" \
"${HOME}/dotfiles/Mackup/Library/Preferences/Adobe Photoshop CC 2014 Settings" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Adobe/Adobe Photoshop CC 2015.5/Presets" \
"${HOME}/dotfiles/Mackup/Library/Preferences/Adobe Photoshop CC 2015 Settings" \
"${HOME}/dotfiles/Mackup/Library/Preferences/Adobe Photoshop CC 2015.5 Settings" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.adobe.Photoshop.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Adobe/Adobe Photoshop CC 2014/Presets" \
"${HOME}/dotfiles/Mackup/Library/Preferences/net.poedit.Poedit.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/net.poedit.Poedit.cfg" \
"${HOME}/dotfiles/Mackup/Library/Quicklook" \
"${HOME}/dotfiles/Mackup/.Rhistory" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.rstudio.RStudio.plist" \
"${HOME}/dotfiles/Mackup/.rstudio-desktop" \
"${HOME}/dotfiles/Mackup/Library/Scripts" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.bohemiancoding.sketch3.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/com.bohemiancoding.sketch3" \
"${HOME}/dotfiles/Mackup/Library/Application Support/SourceTree/hgrc_sourcetree" \
"${HOME}/dotfiles/Mackup/Library/Application Support/SourceTree/sourcetree.license" \
"${HOME}/dotfiles/Mackup/Library/Application Support/SourceTree/hostingservices.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/SourceTree/browser.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Spectacle" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.divisiblebyzero.Spectacle.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.spotify.client.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/io.citruspi.Spotify-Notifications.plist" \
"${HOME}/dotfiles/Mackup/.ssh/config" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Sublime Text 3/Packages/User" \
"${HOME}/dotfiles/Mackup/.subversion" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.apple.Terminal.plist" \
"${HOME}/dotfiles/Mackup/.tmux.conf" \
"${HOME}/dotfiles/Mackup/Library/Application Support/org.videolan.vlc" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.videolan.vlc.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.videolan.vlc.LSSharedFileList.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/org.videolan.vlc" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Code/User/snippets" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Code/User/settings.json" \
"${HOME}/dotfiles/Mackup/Library/Application Support/WhatsApp/Preferences" \
"${HOME}/dotfiles/Mackup/Library/Preferences/WhatsApp-Helper.plist" \
"${HOME}/dotfiles/Mackup/Library/Preferences/WhatsApp.plist" \
"${HOME}/dotfiles/Mackup/Library/Application Support/WhatsApp/settings.json" \
"${HOME}/dotfiles/Mackup/Library/Preferences/com.apple.dt.Xcode.plist" \
"${HOME}/dotfiles/Mackup/Library/Developer/Xcode/UserData/KeyBindings" \
"${HOME}/dotfiles/Mackup/Library/Application Support/Developer/Shared/Xcode/Plug-ins" \
"${HOME}/dotfiles/Mackup/.zshrc" \
)

for L in "${LOCATIONS[@]}"
do
  # echo ">[$L]"
  if [[ -d $L ]]
  then
    # echo "Directory"
    grep -r -i "${QUERY}" "$L" || true
  elif [[ -f $L ]]
  then
    # echo "File"
    grep -i "${QUERY}" "$L" || true
  else
    # echo "Invalid"
    exit 1
  fi
done
