
upgrade() {
    if ! pacman -Qs linux-lts > /dev/null ; then
        yes|sudo pacman -Sy linux-lts
    fi
  yes|sudo pacman -Syyu
}

install_standarddevtools(){
  sudo pacman -S base-devel npm jdk-openjdk jdk8-openjdk git
}

install_flutterdevtools(){
  yay -S android-sdk android-sdk-build-tools android-sdk-platform-tools android-platform-28 flutter
  sudo groupadd dev
  sudo gpasswd -a $USER dev
  sudo setfacl -m g:dev:rwx /opt/android-sdk
  sudo setfacl -m g:dev:rwx /opt/flutter
}

install_codeeditor() {
    sudo pacman -S yay
  yay -S visual-studio-code-bin
  yay -S neovim-nightly-git
}

clear_cache() {
  yay -Sc
}

install_globalmenu() {
  sudo pacman -S appmenu-gtk-module lib32-libdbusmenu-glib lib32-libdbusmenu-gtk2 lib32-libdbusmenu-gtk3 libdbusmenu-glib libdbusmenu-gtk2 libdbusmenu-gtk3 libdbusmenu-qt5
  gpg --keyserver keys.gnupg.net --recv-keys 85F86E317555BECC1C2184BF2C45BA09ABC5D7DA
  yay -S firefox-appmenu-bin
}


DELAY=3 # Number of seconds to display results

while true; do
  clear
  cat << _EOF_
Please Select:

1. Upgrade System and Install LTS Kernel
2. Install Dev Tools (NPM, OpenJDK, Git)
3. Install Flutter Dev Tools
4. Install Global Menu Dependencies (KDE Plasma)
5. Install Code Editor (VSCode, NeoVim)
0. Quit

_EOF_

  read -p "Enter selection [0-5] > "
clear
  if [[ $REPLY =~ ^[0-5]$ ]]; then
    case $REPLY in
      1)
          upgrade
        sleep $DELAY
        continue
        ;;
      2)
          install_standarddevtools
        sleep $DELAY
        continue
        ;;
      3)
          install_flutterdevtools
       sleep $DELAY
        continue
        ;;
      4)
          install_globalmenu
          sleep $DELAY
          continue
          ;;
      5)
          install_codeeditor
          sleep $DELAY
          continue
          ;;
      0)
        exit
        ;;
    esac
  else
    echo "Invalid entry."
    sleep $DELAY
  fi
done
echo "Program terminated."
