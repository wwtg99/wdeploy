#! /bin/bash
if [ "$1" == "-h" ] 
then
	echo "deploy_nginx_php.sh nginx_dir"
	echo "nginx_dir: root directory for nginx user conf, document root and log"
	exit
fi
if [ $# -ge 1 ]
then
	ngdir=$1
	ngdir=${ngdir//\//\\\/}
else
	ngdir=""
fi
# install php 5.6
rpm -Uvh http://ftp.iij.ad.jp/pub/linux/fedora/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum install -y epel-release
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum install -y --enablerepo=remi --enablerepo=remi-php56 php php-opcache \
	php-pecl-apcu php-devel php-mbstring php-mcrypt php-mysqlnd php-pgsql \
	php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof php-pdo php-pear \
	php-fpm php-cli php-xml php-bcmath php-process php-gd php-common
# install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
# install nginx
yum install -y nginx
# config nginx
cp conf/default_nginx.conf /etc/nginx/nginx.conf
sed -i "s/# include dir/include $ngdir\/\*\.conf;/" /etc/nginx/nginx.conf
# start service
systemctl start php-fpm
systemctl enable php-fpm
systemctl start nginx
systemctl enable nginx
