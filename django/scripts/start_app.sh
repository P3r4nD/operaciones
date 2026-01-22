#!/bin/bash
cd /var/www/vhosts/domain.com/django-project/app
source ../app_env/bin/activate
exec gunicorn --reload --access-logfile - --workers 3 --bind 127.0.0.1:8000 app.wsgi:application
