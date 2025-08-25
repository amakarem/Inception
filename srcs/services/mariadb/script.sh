#!/bin/bash

# Load .env from shared volume if exists
if [ -f "/run/secrets/.env" ]; then
  export $(grep -v '^#' /run/secrets/.env | xargs)
fi

# Fallbacks
database_name=${database_name:-mydb}
mysql_user=${mysql_user:-user}
mysql_password=${mysql_password:-$(pwgen -s 16 1)}
mysql_root_user=${mysql_root_user:-root}
mysql_root_password=${mysql_root_password:-$(pwgen -s 16 1)}

# Write .env back to shared volume if missing
if [ ! -f "/run/secrets/.env" ]; then
  cat <<EOF > /run/secrets/.env
database_name=${database_name}
mysql_user=${mysql_user}
mysql_password=${mysql_password}
mysql_root_user=${mysql_root_user}
mysql_root_password=${mysql_root_password}
EOF
  echo ".env created in shared volume"
fi

# Start MariaDB for initialization
service mysql start

# Create DB and users
mysql -e "CREATE DATABASE IF NOT EXISTS ${database_name};"
mysql -e "CREATE USER '${mysql_user}'@'%' IDENTIFIED BY '${mysql_password}';"
mysql -e "GRANT ALL PRIVILEGES ON ${database_name}.* TO '${mysql_user}'@'%';"
mysql -e "ALTER USER '${mysql_root_user}'@'localhost' IDENTIFIED BY '${mysql_root_password}';"
mysql -e "FLUSH PRIVILEGES;"

# Stop temporary server
mysqladmin -u${mysql_root_user} -p${mysql_root_password} shutdown

exec "$@"
