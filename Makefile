all:
	@sudo systemctl stop apache2 #free port 80
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

copy-html:
	sudo cp ./srcs/requirements/wordpress/conf/index.php /var/www/html/index.php 

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re: down copy-html all

status:
	@sudo docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"

clean:
	docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);

export:
	cat .env | export
# export DOMAIN_NAME=ast-jean.42.fr
# export MYSQL_HOSTNAME=mariadb
# export MYSQL_DATABASE=wordpress
# export MYSQL_USER=ast-jean
# export MYSQL_PASSWORD=1234
# export MYSQL_ROOT_PASSWORD=1234

copy_paste_no_work:
	VBoxClient --clipboard

.PHONY: all re down clean

#Create Database
#	CREATE DATABASE wordpress;
#Create user
#	CREATE USER 'ast-jean'@'localhost' IDENTIFIED BY '1234';
#Grant priv
#	GRANT ALL PRIVILEGES ON wordpress.* TO 'ast-jean'@'localhost';
#FLUSH PRIVILEGES;
#show dbs
#	SHOW DATABASES;
#Import .sql to maria db docker container
#	docker cp srcs/requirements/mariadb/conf/wordpress.sql mariadb:/tmp
#	docker exec -i mariadb -it bash
#	mysql -u username -p database_name < /tmp/wordpress.sql
#	rm /tmp/wordpress.sql
#See in docker container
#	SELECT * FROM wp_users WHERE user_login = 'ast-jean';
#Change value from db
#UPDATE wp_users SET user_pass = MD5('1234') WHERE user_login = 'ast-jean';
# Kill server to test restart
# docker exec -it wordpress kill 1
