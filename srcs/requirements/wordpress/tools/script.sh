#!bin/bash

# wait for mysql to start
sleep 10
# Install Wordpress

# echo "Database: $database_name"
# echo "User: $mysql_user"
# echo "Password: $mysql_password"
# echo "dbhost: $mysql_host"

if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create --dbname=$database_name --dbuser=$mysql_user \
        --dbpass=$mysql_password --dbhost=$mysql_host --allow-root  --skip-check

    wp core install --url=$domain_name --title=$brand --admin_user=$wordpress_admin_username \
        --admin_password=$wordpress_admin_password --admin_email=$wordpress_admin_email \
        --allow-root

    wp user create $login $wp_user_email --role=author --user_pass=$wp_user_pwd --allow-root

 #   wp config  set WP_DEBUG true  --allow-root

    wp config set FORCE_SSL_ADMIN 'false' --allow-root

    wp config  set WP_CACHE 'true' --allow-root

    wp plugin install redis-cache --allow-root

    wp config set WP_REDIS_HOST redis --allow-root --type=constant
    # Optional: set port, password, database
    wp config set WP_REDIS_PORT 6379 --allow-root --type=constant
    wp config set WP_REDIS_PASSWORD "" --allow-root --type=constant
    wp config set WP_REDIS_DATABASE 0 --allow-root --type=constant

    wp plugin activate redis-cache --allow-root

    wp redis enable --allow-root

    chmod 777 /var/www/html/wp-content

    # install theme

    wp theme install twentyfifteen

    wp theme activate twentyfifteen

    wp theme update twentyfifteen
fi


/usr/sbin/php-fpm7.4 -F