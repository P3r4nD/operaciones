# Django Operations

## Desplegar entorno Django + Gunicorn + NGINX en producción
Se asume que el entorno virtual en el que corre la instalación de Django está hubicado en la raíz del dominio donde corre NGINX.

- /var/www/vhosts/dominio.com/ (NGINX)
    - [start_app.sh](scripts/start_app.sh) 
    - django-project/
      - django_env/ (entorno virtual venv)
      - app/

## Comprobar actualizaciones de una instalación Django y guardar resultado

Configuramos [django/scripts/djangoup.sh](scripts/djangoup.sh)

```bash
VENV_PATH="/var/www/vhosts/dominio.com/django-project/django_env"
OUTPUT_FILE="/tmp/check_libraries_report.txt"
```
Disparamos mediante ```crontab``` o servicio ```systemd```

```djangoup.sh``` ejecuta ```djangoup.py```
