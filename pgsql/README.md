# Operaciones PostgreSQL
- [Instalación](#install)
- [Configuración inicial](#config)
- [Backups](#bk)

<a name="install"></a>
## Instalación de PostgreSQL en AlmaLinux u otras basadas en RHEL
> ⚠️ **NOTA:**  
> Los procedimientos que siguen son útiles para desplegar manualmente PostgreSQL, el despliegue del servicio en producción es ligeramente distinto, ver Despliegue.

1. **Habilitar el repositorio oficial de PostgreSQL**
   ```bash
   sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm

2. **Instalar PostgreSQL**
    ```bash
    sudo dnf install -y postgresql15 postgresql15-server
    ```
3. **Inicializar la base de datos**
    ```bash
    sudo /usr/pgsql-15/bin/postgresql-15-setup initdb
    ```
4. **Habilitar y arrancar el servicio**
    ```bash
    sudo systemctl enable postgresql-15
    sudo systemctl start postgresql-15
    ```
5. **Verificar estado del servicio**
    ```bash
    systemctl status postgresql-15
    ```
<a name="config"></a>
### Configuración inicial de PostgreSQL

1. **Acceder al usuario por defecto de PostgreSQL:**
```bash
sudo -i -u postgres
```
2. **Crear base de datos y usuario**
```bash
createdb mi_base
createuser mi_usuario
psql
```
3. **Asignar contraseña y permisos**
```bash
ALTER USER mi_usuario WITH ENCRYPTED PASSWORD 'mi_password';
GRANT ALL PRIVILEGES ON DATABASE mi_base TO mi_usuario;
\q
```
---
<a name="bk"></a>
## Backup PostgreSQL – Script para automatizar

- Este script realiza copias de seguridad de múltiples bases de datos PostgreSQL utilizando un único usuario y contraseña definidos en el archivo `.pg_env`.
- Dicho archivo de configuración u otro con otro nombre, debe estar bien referenciado dentro del script:
```bash
ENV_FILE="/etc/pg_sql/pg_env"
```
- Incluye verificación de integridad, retención automática, permisos opcionales y envío de email opcional.

---

### 📌 Características principales

- Backup comprimido (`.sql.gz`) por cada base de datos.
- Verificación de integridad con `gzip -t`.
- Registro de checksums SHA-256.
- Limpieza automática de backups antiguos.
- Envío de email opcional.
- Reasignación de permisos opcional.
- Soporte para múltiples bases de datos con un único usuario PostgreSQL.

---

### 📁 Archivo de configuración (`/etc/pg_sql/pg_env`)

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
