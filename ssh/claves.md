# Generar claves SSH

## Crear un par de claves SSH para autenticación sin contraseña en servidores remotos.
Crear llaves por defecto presionando enter cuando pida passphrase:
## :robot: Comando 
```bash
ssh-keygen -t ed25519 -C "tu_email@example.com"
```

### Asegurar permisos
```
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```
## Crear claves SSH con nombres propios
```bash
ssh-keygen -t ed25519 -C "backup@servidor" -f ~/.ssh/id_backup
```
# :outbox_tray: Copiar la clave pública al servidor remoto

## `ssh-copy-id` con puerto específico

```bash
ssh-copy-id -i ~/.ssh/id_backup.pub -p 2222 usuario@host
```
## Copiar la clave mediante ```scp```
```bash
scp -P 2222 ~/.ssh/id_backup.pub usuario@host:/tmp/
```
### En el servidor remoto
```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat /tmp/id_backup.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
rm /tmp/id_backup.pub
```
#  Verificar autenticación
```bash
ssh -i ~/.ssh/id_backup -p 2222 backup@host
```
## Configurar conexión
Editar/crear  ```~/.ssh/config``` 

```bah
Host backup-server
    HostName 192.168.1.50
    User backup
    Port 2222
    IdentityFile ~/.ssh/id_backup
    IdentitiesOnly yes
```
### Conectar con nueva configuración
```ssh backup-server```

# Gestión y mantenimiento
## Listar claves cargadas en el agente SSH
```bash
ssh-add -l
```
## Añadir una clave al agente
```bash
ssh-add ~/.ssh/id_backup
```
## Eliminar clave del agente
```bash
ssh-add -d ~/.ssh/id_backup
```
