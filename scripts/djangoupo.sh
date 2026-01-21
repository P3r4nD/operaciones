#!/bin/bash
# -----------------------------
# Bash para ejecutar el archivo djangoup.py dentro del entorno venv
# y devolver información de actualizaciones del mismo
# -----------------------------

# -----------------------------
# Configuración
# -----------------------------
VENV_PATH="/var/www/vhosts/dominio.com/django-project/django_env"
OUTPUT_FILE="/tmp/check_libraries_report.txt"

# -----------------------------
# Activar entorno
# -----------------------------
source "$VENV_PATH/bin/activate"

# -----------------------------
# Ejecutar comprobaciones
# -----------------------------
python3 /home/usuario/djangoup.py > "$OUTPUT_FILE"

# -----------------------------
# Desactivar entorno
# -----------------------------
deactivate

# -----------------------------
# Devolver el log
# -----------------------------
cat "$OUTPUT_FILE"
