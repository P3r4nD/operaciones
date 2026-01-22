# Django Operations

## Desplegar entorno Django + Gunicorn + NGINX

## Comprobar actualizaciones de una instalación Django y guardar resultado

Configuramos [django/scripts/djangoup.sh](scripts/djangoup.sh)

```bash
VENV_PATH="/var/www/vhosts/dominio.com/django-project/django_env"
OUTPUT_FILE="/tmp/check_libraries_report.txt"
```
Disparamos mediante ```crontab``` o servicio ```systemd```

```djangoup.sh``` ejecuta ```djangoup.py```
