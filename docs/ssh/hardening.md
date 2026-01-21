# Hardening básico de SSH

Este documento recoge las medidas esenciales para endurecer la configuración del servicio SSH en un servidor Linux. No pretende ser una guía exhaustiva, sino un conjunto de prácticas seguras y fáciles de aplicar.

---
## Comprobar configuración SSH
```bash
sshd -t
```


## Deshabilitar acceso por contraseña y habilitar acceso basado en claves

Forzar el uso de claves SSH evita ataques de fuerza bruta.

En `/etc/ssh/sshd_config`:

```bash
PasswordAuthentication no
KbdInteractiveAuthentication no
ChallengeResponseAuthentication no
```
```bash
AuthenticationMethods publickey
PubkeyAuthentication yes
```
---

## Deshabilitar acceso con clave privada sin passphrase (opcional)

```bash
PermitEmptyPasswords no
```
---

## Deshabilitar acceso directo del usuario root

Evita que root sea objetivo de ataques automatizados.

```bash
PermitRootLogin no
```


Si necesitas privilegios:

- Conéctate como usuario normal
- Usa `sudo`

---

## Cambiar el puerto SSH
```bash
Port 2222
```

Acompañar con firewall.

---
## Limite por IP
```ListenAddress 192.168.1.xx```

## Limitar usuarios o grupos permitidos
```bash
AllowUsers usuario1 usuario2
AllowGroups sshusers
```
## Limitar intentos de autenticación fallida
```MaxAuthTries 3 ```

## Limitar tiempo de conexión abierta sin autenticación
```LoginGraceTime 60```

## Limitar conexiones simultaneas no autenticadas
```MaxStartups 3```

## Banner de advertencia para los usuarios de SSH
```Banner /etc/issue```

## Tiempo de espera hasta el cierre de sesión inactiva
```bash
ClientAliveInterval 300
ClientAliveCountMax 0
```
## Deshabilitar la autenticación basada en el host
```HostbasedAuthentication no```

## Deshabilitar X11forwarding
Impedir que el servidor gráfico X11 haga forwarding a través de SSH
```X11forwarding no```


