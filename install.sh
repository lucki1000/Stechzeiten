##############################
# First run Installer        #
# for Stechzeiten            #
#                            #
# Created by                 #
# Lukas Bonrath              #
##############################

#enable SPI on Raspberry Pi OS
if lsb_release -a | grep "Rasp"
then
    echo "dtparam=spi=on" | sudo tee -a /boot/config.txt
    echo "device_tree_param=spi=on" | sudo tee -a /boot/config.txt
    echo "dtoverlay=spi-bcm2708" | sudo tee -a /boot/config.txt
fi

#install depencies from repos
sudo apt update
sudo apt install mariadb-common mariadb-server python3-dev python3-pip tmux -y

#install additional depencies with pip3
sudo pip3 install spidev
sudo pip3 install mfrc522
sudo pip3 install mysql
sudo pip3 install mysql-connector-python-rf

#create database and user
chmod +x create_database.sh
./create_database.sh

#define WebRoot and copy Webviewer to webroot
read -p "Type your webroot, common webroot from Apache2 is /var/www/html/: " webroot_path
if [[ -z "$webroot_path" ]]; then
   webroot_path = "/var/www/html/"
fi
sudo cp -r website/* $webroot_path

#start stechzeiten with system
echo "sudo -H -u pi /etc/stechzeiten/stechzeiten.sh" | sudo tee /etc/rc.local

#copy stechzeiten(folder) to /etc/ here are the needed files to run the python script
sudo cp -r stechzeiten /etc/

#cleanup not longer needed files
sudo rm -- "$0"
sudo rm -rf ../Stechzeiten
