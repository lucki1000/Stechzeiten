sudo mysql -uroot -e "CREATE USER 'stechzeit_nutzer'@'localhost' IDENTIFIED BY 'blabla'"
sudo mysql -uroot -e "CREATE DATABASE stechzeiten"
sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON stechzeiten.* TO 'stechzeit_nutzer'@'localhost'"
sudo mysql -uroot -e "CREATE TABLE stechzeiten ( ID bigint, Datum date, Uhrzeit time, Status text )"
sudo mysql -uroot -e "FLUSH PRIVILEGES"

