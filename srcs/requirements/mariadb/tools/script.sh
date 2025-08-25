#!/bin/bash

# echo "Database: $database_name"
# echo "User: $mysql_user"
# echo "Password: $mysql_password"

set -e

echo "Starting MariaDB..."

# Start mariadb in the background
mysqld_safe --datadir=/var/lib/mysql --skip-networking=0 --bind-address=0.0.0.0 &

# Wait until MariaDB is ready
until mysql -u root -e "SELECT 1" &>/dev/null; do
  echo "Waiting for MariaDB to be ready..."
  sleep 2
done

echo "MariaDB is ready."

# Now run setup
mysql -u root <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${database_name};
    CREATE USER IF NOT EXISTS '${mysql_user}'@'%' IDENTIFIED BY '${mysql_password}';
    GRANT ALL PRIVILEGES ON ${database_name}.* TO '${mysql_user}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "Database setup complete."

# Keep foreground process (replace shell with mysqld_safe)
wait -n
