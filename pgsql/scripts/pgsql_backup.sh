#!/bin/bash

# Cargar variables desde archivo env
ENV_FILE="/etc/pg_sql/pg_env"
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo "[ERROR] Archivo de configuración $ENV_FILE no encontrado."
    exit 1
fi

# Crear directorio de backups
mkdir -p "$BACKUP_DB_DIR"

DATE=$(date +%F_%H-%M)

MAIL_BODY="Backup iniciado para $(date '+%F %H:%M:%S')\n"

for DB_NAME in $DB_NAMES; do

    BACKUP_FILE="$BACKUP_DB_DIR/${DB_NAME}_$DATE.sql.gz"

    echo "Iniciando backup de $DB_NAME..."

    PGPASSWORD="$DB_PASS" "$PG_DUMP_BIN" \
        -U "$DB_USER" \
        -h "$DB_HOST" \
        -p "$DB_PORT" \
        "$DB_NAME" | gzip > "$BACKUP_FILE"

    # Verificar gzip
    if gzip -t "$BACKUP_FILE"; then
        echo "[OK] Backup $BACKUP_FILE verificado correctamente (gzip OK)." >&2
        sha256sum "$BACKUP_FILE" >> "$BACKUP_DB_DIR/checksums_postgresql.txt"
        MAIL_BODY+="[OK] Backup BD $DB_NAME verificado correctamente (gzip OK)\n"
    else
        echo "[Error]: El backup $BACKUP_FILE está corrupto." >&2
        MAIL_BODY+="[Error]: Backup BD $DB_NAME (gzip corrupto)\n"
        exit 1
    fi
done

# Limpiar backups antiguos
find "$BACKUP_DB_DIR" -type f -name "*.sql.gz" -mtime +"$RETENTION_DAYS" -delete

# Asignar permisos opcionalmente
if [[ -n "$backup_user" || -n "$backup_group" ]]; then
    OWNER="${backup_user:-root}:${backup_group:-root}"
    echo "Asignando permisos a $OWNER..."
    chown -R "$OWNER" "$BACKUP_DIR"
    chmod -R 700 "$BACKUP_DIR"
fi

# Enviar email opcionalmente
if [[ "$send_email" == "true" ]]; then
    if [[ -n "$email_address" ]]; then
        echo -e "$MAIL_BODY" | mail -s "Backup PostgreSQL" "$email_address"
    else
        echo "[Aviso]: send_email=true pero email_address no está definido."
    fi
fi
