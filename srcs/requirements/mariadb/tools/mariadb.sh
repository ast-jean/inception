#!/bin/sh
echo "Running mariadb.sh.."
mysql_install_db
/etc/init.d/mysql start

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
	echo "Db $MYSQL_DATABASE  exist. Skipping.."
else
	mysql -u root  <<-EOF
	SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.db WHRE Dd='test' OR Db='test\\_%';
	FLUSH PRIVILEGES;
EOF

mysql -u root -p "${MYSQL_ROOT_PASSWORD}"<<-EOF
	CREATE DATABASE IF NOT EXITS $MYSQL_DATABASE;
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
	FLUSH PRIVILEGES;
EOF
	if [ -f /usr/local/bin/wordpress.sql ]; then
	mysql -uroot -p"$MYSQL_ROOT_PASSWORD" $MYSQL_DATABASE < /usr/local/bin/wordpress.sql
fi
fi
/etc/init.d/mysql stop
exec "$@"
