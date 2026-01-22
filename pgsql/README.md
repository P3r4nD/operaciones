# Backup PostgreSQL – Script Automatizado (versión simplificada)

- Este script realiza copias de seguridad de múltiples bases de datos PostgreSQL utilizando un único usuario y contraseña definidos en el archivo `.pg_env`.
- Dicho archivo de configuración u otro con otro nombre, debe estar bien referenciado dentro del script:
```bash
ENV_FILE="/etc/pg_sql/pg_env"
```
- Incluye verificación de integridad, retención automática, permisos opcionales y envío de email opcional.

---

## 📌 Características principales

- Backup comprimido (`.sql.gz`) por cada base de datos.
- Verificación de integridad con `gzip -t`.
- Registro de checksums SHA-256.
- Limpieza automática de backups antiguos.
- Envío de email opcional.
- Reasignación de permisos opcional.
- Soporte para múltiples bases de datos con un único usuario PostgreSQL.

---

## 📁 Archivo de configuración (`/etc/pg_sql/pg_env`)

El script carga todas sus variables desde este archivo.  
Ejemplo recomendado:

```ini
# Directorios
BACKUP_DIR="/var/backups"
BACKUP_DB_DIR="/var/backups/postgresql"
BACKUP_LOGS_DIR="/var/log/backups"

# PostgreSQL
PG_DUMP_BIN="/usr/pgsql-14/bin/pg_dump"

# Usuario y contraseña comunes
DB_USER="backupuser"
DB_PASS='contraseña con símbolos : " espacios etc'
DB_HOST="localhost"
DB_PORT=5432

# Lista de bases de datos (separadas por espacios)
DB_NAMES="db1 db2 db3"

# Retención de backups (días)
RETENTION_DAYS=30

# Opcional: envío de email
send_email=true
email_address="admin@xample.com"

# Opcional: permisos
backup_user="backupus"
backup_group="backupus"
