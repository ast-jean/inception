all:
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re: stop_dockers
	@docker compose -f srcs/docker-compose.yml up -d --build

stop_dockers:
	@docker stop $$(docker ps -qa);\

clean: stop_dockers
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

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
#	UPDATE wp_users SET user_pass = MD5('1234') WHERE user_login = 'ast-jean';
# Kill server to test restart
# 	docker exec -it wordpress kill 1