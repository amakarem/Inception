#!/bin/bash

# Load .env if exists
if [ -f "/run/secrets/.env" ]; then
    export $(grep -v '^#' /run/secrets/.env | xargs)
elif [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Set defaults if variables are missing
database_name=${database_name:-mydb}
mysql_user=${mysql_user:-user}
mysql_password=${mysql_password:-$(pwgen -s 16 1)}
mysql_root_user=${mysql_root_user:-root}
mysql_root_password=${mysql_root_password:-$(pwgen -s 16 1)}

# If .env does not exist, create it with generated values
if [ ! -f ".env" ]; then
    cat <<EOF > .env
database_name=${database_name}
mysql_user=${mysql_user}
mysql_password=${mysql_password}
mysql_root_user=${mysql_root_user}
mysql_root_password=${mysql_root_password}
EOF
    echo ".env file created with random credentials"
fi

# Start MariaDB service
service mysql start

# Setup database and users
mysql -e "CREATE DATABASE IF NOT EXISTS ${database_name};"
mysql -e "CREATE USER '${mysql_user}'@'%' IDENTIFIED BY '${mysql_password}';"
mysql -e "GRANT ALL PRIVILEGES ON ${database_name}.* TO '${mysql_user}'@'%';"
mysql -e "ALTER USER '${mysql_root_user}'@'localhost' IDENTIFIED BY '${mysql_root_password}';"
mysql -e "FLUSH PRIVILEGES;"

# Stop temporary MariaDB server
mysqladmin -u${mysql_root_user} -p${mysql_root_password} shutdown

# Run main command
exec "$@"
