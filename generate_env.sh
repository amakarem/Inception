#!/bin/bash
ENV_FILE="./secrets/.env"

mkdir -p ./secrets

if [ ! -f "$ENV_FILE" ]; then
  echo "Creating .env file with random credentials..."
  database_name=mydb
  mysql_user=${USERNAME:-aelaaser}
  mysql_password=$(pwgen -s 16 1)
  mysql_root_user=root
  mysql_root_password=$(pwgen -s 16 1)
  wordpress_admin_password=$(pwgen -s 16 1)
  cat <<EOF > "$ENV_FILE"
database_name=$database_name
mysql_user=$mysql_user
mysql_password=$mysql_password
mysql_root_user=$mysql_root_user
mysql_root_password=$mysql_root_password
mysql_host=mariadb
username=$mysql_user
domain_name=$mysql_user.42.fr
wordpress_admin_password=$wordpress_admin_password
wordpress_admin_email=$mysql_user@42.fr
EOF
fi

echo ".env file ready at $ENV_FILE"
