check_package() {
    if ! which yay > /dev/null ; then
        git clone https://aur.archlinux.org/yay-bin.git
        cd yay-bin
        makepkg -si
    fi
   package=($@)
   newpack=()
   for i in ${package[@]}; do
       if ! pacman -Qs $i > /dev/null ; then
           newpack+="$i "
       fi
   done

   if [ -n "$newpack" ]; then
       yay -S $newpack
   fi
}

upgrade() {
    sudo pacman -Syyu
}

install_standarddevtools(){
    check_package base-devel npm jdk-openjdk jdk8-openjdk git clang cmake extra-cmake-modules
}

install_flutterdevtools(){
  check_package android-sdk android-sdk-build-tools android-sdk-platform-tools android-platform-28 flutter
  add_to_group /opt/android-sdk
  add_to_group /opt/flutter
}

install_codeeditor() {
  check_package visual-studio-code-bin
  cat settings/vscode-extensions/vscode-extensions-list | 
    while read e; do
      code --install-extensions $e
    done
}

clear_cache() {
  yay -Sc
}

add_to_group() {
    if ! grep -q dev /etc/group ; then
        sudo groupadd dev
    fi

    if ! groups | grep dev >> /dev/null ; then
        sudo gpasswd -a $USER dev
    fi

    sudo chown roo:dev -R $@

}

install_globalmenu() {
  check_package appmenu-gtk-module lib32-libdbusmenu-glib lib32-libdbusmenu-gtk2 lib32-libdbusmenu-gtk3 libdbusmenu-glib libdbusmenu-gtk2 libdbusmenu-gtk3 libdbusmenu-qt5
  gpg --keyserver keys.gnupg.net --recv-keys 85F86E317555BECC1C2184BF2C45BA09ABC5D7DA
  check_package firefox-appmenu-bin
}

install_httpserver(){
    check_package apache php php-apache mariadb phpmyadmin composer

    # copy all required files
    sudo cp -r settings/httpserver/httpd/* /etc/httpd/conf/
    sudo cp -r settings/httpserver/php/* /etc/php/

    # install mysql database directory
    sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    # start mariadb service
    sudo systemctl start mariadb

    # enable autostart mariadb service
    sudo systemctl enable mariadb

    # secure mysql installation
    sudo mysql_secure_installation

    # start apache service
    sudo systemctl start httpd

    # enable autostart httpd service
    sudo systemctl enable httpd

    # set /srv/http to accessible
    add_to_group /srv/http
}

install_ftpserver(){
     check_package ufw vsftpd filezilla
     sudo ufw allow 20/tcp
     sudo ufw allow 21/tcp
     sudo ufw allow 990/tcp
     sudo ufw allow 40000:50000/tcp
     sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
     echo $USER >> /tmp/vsftpd.userlist
     sudo mv /tmp/vsftpd.userlist /etc
     sudo cp settings/ftpserver/vsftpd.conf /etc/vsftpd.conf
     sudo mkdir /srv/ftp/$USER/
     add_to_group /srv/ftp
}


DELAY=3 # Number of seconds to display results

while true; do
  clear
  cat << _EOF_
Please Select:

1. Upgrade System and Install LTS Kernel
2. Install Dev Tools (NPM, OpenJDK, Git, Clang)
3. Install Flutter Dev Tools (Android SDK, Flutter SDK, Dart)
4. Install Global Menu Dependencies
5. Install Code Editor (Visual Studio Code)
6. Install HTTP Server (Apache, PHP, MariaDB)
7. Install FTP Server (vsftpd, FileZilla)
0. Quit

_EOF_

  read -p "Enter selection [0-7] > "
clear
  if [[ $REPLY =~ ^[0-7]$ ]]; then
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
      6)
          install_httpserver
          sleep $DELAY
          continue
          ;;
      7)
          install_ftpserver
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
echo "After Running this Script Please re-login to use Application"
sleep 4
clear


