CREATE DATABASE IF NOT EXISTS;
CREATE USER IF NOT EXISTS 'ast-jean'@'%' IDENTIFIED BY '1234' ;
GRANT ALL PRIVILEGES ON wordpress.* TO 'ast-jean'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '1234' ;
FLUSH PRIVILEGES;