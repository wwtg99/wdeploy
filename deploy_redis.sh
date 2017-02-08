#! /bin/bash
yum install -y redis
systemctl start redis
systemctl enable redis
