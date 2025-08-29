#!/bin/bash
ENV_FILE="./secrets/.env"

mkdir -p ./secrets

if [ ! -f "$ENV_FILE" ]; then
  echo "Creating .env file with random credentials..."
  database_name=mydb
  mysql_user=${USERNAME:-aelaaser}
  mysql_password=$(< /dev/urandom tr -dc 'A-Za-z0-9!@#$%^&*()_+=' | head -c16)
  mysql_root_user=root
  mysql_root_password=$(< /dev/urandom tr -dc 'A-Za-z0-9!@#$%^&*()_+=' | head -c16)
  wordpress_admin_password=$(< /dev/urandom tr -dc 'A-Za-z0-9!@#$%^&*()_+=' | head -c12)
  wp_user_pwd=$(< /dev/urandom tr -dc 'A-Za-z0-9!@#$%^&*()_+=' | head -c12)
  ftp_password=$(< /dev/urandom tr -dc 'A-Za-z0-9!@#$%^&*()_+=' | head -c10)
  cat <<EOF > "$ENV_FILE"
database_name=$database_name
mysql_user=$mysql_user
mysql_password=$mysql_password
mysql_root_user=$mysql_root_user
mysql_root_password=$mysql_root_password
mysql_host=mariadb
username=$mysql_user
domain_name=$mysql_user.42.fr
wordpress_admin_username=$mysql_user
wordpress_admin_password=$wordpress_admin_password
wordpress_admin_email=$mysql_user@42.fr
login=user
wp_user_pwd=$wp_user_pwd
wp_user_email=user@42.fr
FTP_USER=$mysql_user
FTP_PASS=$ftp_password
EOF
fi

echo ".env file ready at $ENV_FILE"
