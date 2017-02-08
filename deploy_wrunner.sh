#! /bin/bash
# install redis and Celery
pip install redis
pip install Celery
# install wrunner
git clone https://github.com/wwtg99/wrunner.git
# install supervisor
# optional
pip install supervisor
echo_supervisord_conf > /etc/supervisord.conf
echo 'supervisor conf file in /etc/supervisord.conf'
