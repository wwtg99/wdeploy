#! /bin/bash
# install postgresql 9.6
yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum install -y postgresql96-server postgresql96-contrib postgresql96-devel
# initialize
/usr/pgsql-9.6/bin/postgresql96-setup initdb
systemctl start postgresql-9.6
systemctl enable postgresql-9.6
echo 'Postgresql 9.6 is installed! '
echo 'You may need to change these conf files:'
echo '/var/lib/pgsql/9.6/data/postgresql.conf'
echo '/var/lib/pgsql/9.6/data/pg_hba.conf'
