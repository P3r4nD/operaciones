# Django Operations

## Desplegar entorno Django + Gunicorn + NGINX en producción
- Se asume que el entorno virtual en el que corre la instalación de Django está hubicado en la raíz del dominio donde corre NGINX.
- Todas las variables de configuración que necesita settings.py de Django, se cargan mediante ```dotenv``` desde archivo .env

- /var/www/vhosts/dominio.com/ (NGINX)
    - [start_app.sh](scripts/start_app.sh) 
    - django-project/
      - django_env/ (entorno virtual venv)
      - app/.env (Variables de entorno que se pasan a settings.py)
### Script para iniciar el entorno virtual Django
[start_app.sh](scripts/start_app.sh)
```bash
#!/bin/bash
cd /var/www/vhosts/domain.com/django-project/app
source ../app_env/bin/activate
# En pre-producción puede pasarse la opción --reload para recarga automática al editar archivos no static
exec gunicorn --access-logfile - --workers 10 --bind 127.0.0.1:8000 app.wsgi:application
```
### Servicio ```systemd``` para mantener el entorno activo
[django-gunicorn.service](scripts/django-gunicorn.service)

```ini
[Unit]
Description=Gunicorn daemon for DJANGO-PROJECT
After=network.target

[Service]
User=semd
Group=psacln
WorkingDirectory=/var/www/vhosts/domain.com/django-project/app
ExecStart=/bin/bash /var/www/vhosts/domain.com/start_app.sh
EnvironmentFile=/var/www/vhosts/domain.com/django-project/app/.env
Environment="DJANGO_SETTINGS_MODULE=app.settings"
Environment="PYTHONPATH=/var/www/vhosts/domain.com/django-project"
[Install]
WantedBy=multi-user.target
```
#### Activar servicio
```bash
sudo systemctl daemon-reload
sudo systemctl enable django-gunicorn.service
sudo systemctl start django-gunicorn.service
```
#### Verificar y logs
```bash
sudo systemctl status django-gunicorn.service
journalctl -u noip-duc.service -f
```
---
## Comprobar actualizaciones de una instalación Django y guardar resultado

Configuramos [django/scripts/djangoup.sh](scripts/djangoup.sh)

```bash
VENV_PATH="/var/www/vhosts/dominio.com/django-project/django_env"
OUTPUT_FILE="/tmp/check_libraries_report.txt"
```
Disparamos mediante ```crontab``` o servicio ```systemd```

```djangoup.sh``` ejecuta ```djangoup.py```
