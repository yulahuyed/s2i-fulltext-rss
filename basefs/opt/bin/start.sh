#!/bin/bash

sed -i "s/max_entries = 10/max_entries = 50/g" /opt/app-root/src/public/full-text-rss/config.php
sed -i "s/default_entries = 5/default_entries = 20/g" /opt/app-root/src/public/full-text-rss/config.php

# Creates the .env file needs by Laravel using
# The environment variables set both by the system
# and the openshift application (deploy configuration)
env > /opt/app-root/src/.env

# Starts PHP FPM in a non-deamon mode (that is set on configuration)
php-fpm --fpm-config /etc/php7/php-fpm.conf -c /etc/php7/php.ini

# Starts caddy as a deamon using the custom configuration file
caddy -conf /etc/caddy/caddy.conf
