#!/bin/bash

# Activar opciones de seguridad:
# -e → salir si un comando falla
# -u → error al usar variables no definidas
# -o pipefail → fallar si cualquier comando en una tubería falla
set -euo pipefail

##############################
# CONFIGURACIÓN
##############################

# Usuario remoto SSH
REMOTE_USER=""

# Host remoto
REMOTE_HOST=""

# Puerto SSH remoto
REMOTE_PORT=""

# Ruta remota con los backups
REMOTE_PATH=""

# Ruta local donde copiar los backups
LOCAL_PATH=""

# Ruta de log
LOG_FILE=""

# Usar dry-run (true para simular, false para ejecutar copia real)
DRYRUN=true

# Opcional: clave específica si no es la predeterminada
SSH_KEY="$HOME/.ssh/id_ed25519"

##############################
# CONSTRUCCIÓN DEL COMANDO
##############################

# Opciones de rsync
RSYNC_OPTS="-av --progress"

# Añadimos dry-run si DRYRUN=true
if [ "$DRYRUN" = true ]; then
    RSYNC_OPTS="$RSYNC_OPTS -n"
    echo "=== MODO SIMULACIÓN ACTIVADO ==="
else
    echo "=== EJECUTANDO COPIA REAL ==="
fi

# Comando SSH para rsync
SSH_CMD="ssh -i $SSH_KEY -p $REMOTE_PORT"

# Comando rsync completo
CMD="rsync $RSYNC_OPTS -e \"$SSH_CMD\" $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH $LOCAL_PATH"

##############################
# EJECUCIÓN
##############################

echo "Ejecutando comando:"
echo "$CMD"
echo "==============================="

# Añadimos --stats para resumen al final
CMD="$CMD --stats"

# Ejecutar y guardar salida en log
RSYNC_OUTPUT=$(eval "$CMD" 2>&1)
echo "$RSYNC_OUTPUT" >> "$LOG_FILE"

# Extraer resumen del rsync
SUMMARY=$(echo "$RSYNC_OUTPUT" | grep -E 'Number of files|Number of created files|Number of deleted files|Number of regular files transferred|Total file size|sent|received|bytes/sec')

# Añadimos la fecha al final del log
echo "===============================" >> "$LOG_FILE"
echo "Resumen de ejecución: $(date)" >> "$LOG_FILE"
echo "$SUMMARY" >> "$LOG_FILE"
echo "==============================="

# Mostrarlo en terminal
echo "Resumen de ejecución:"
echo "$SUMMARY"
