sudo mysql -uroot <<MYSQL_SCRIPT
CREATE USER 'stechzeit_nutzer'@'localhost' IDENTIFIED BY 'blabla';
CREATE DATABASE stechzeiten;
GRANT ALL PRIVILEGES ON stechzeiten.* TO 'stechzeit_nutzer'@'localhost';
USE stechzeiten;
CREATE TABLE stechzeiten ( ID text, Datum date, Uhrzeit time, Status text );
FLUSH PRIVILEGES;
MYSQL_SCRIPT