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

#create database and user
chmod +x create_database.sh
./create_database.sh

#define WebRoot and copy Webviewer to webroot
read -p "Type your webroot, common webroot from Apache2 is /var/www/html/: " webroot_path
sudo cp -r website/* $webroot_path

#add a new service file to systemd and enable on startup
sudo cp -r systemd_unit/stechzeiten.service /etc/systemd/system/
sudo systemctl enable stechzeiten.service

#copy stechzeiten(folder) to /etc/ here are the needed files to run the python script
sudo cp -r stechzeiten /etc/

#cleanup not longer needed files
sudo rm -- "$0"
sudo rm -rf ../Stechzeiten
