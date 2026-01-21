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

## Forzar protocolo y algoritmos seguros (revisar según versión de ```sshd```
SSH ya no usa el protocolo 1, asegurarlo:
```Protocol 2```
Opcionalmente endurecer algoritmos (revisar versiones y necesidades):
```bash
KexAlgorithms curve25519-sha256
Ciphers chacha20-poly1305@openssh.com
MACs hmac-sha2-512,hmac-sha2-256
```
## Usar AllowTcpForwarding y PermitTunnel (según necesidad)
```bash
AllowTcpForwarding no
PermitTunnel no
```
## Registrar mejores logs para auditoría
```LogLevel VERBOSE```

---
## Usar firewall para limitar acceso

Revisar [iptables](https://github.com/P3r4nD/operaciones/tree/main/docs/iptables/ipt.md) e [ipset](https://github.com/P3r4nD/operaciones/tree/main/docs/ipset/ips.md)

Ejemplo con UFW:

```bash
ufw allow 2222/tcp
ufw deny from any to any port 22
```
O limitando por IP
```bash
ufw allow from 192.168.1.xx to any port 2222 proto tcp
```
---
## Activar protección contra fuerza bruta (Fail2ban)
Configuraciones Fail2ban [Fail2ban](https://github.com/P3r4nD/operaciones/tree/main/docs/fail2ban/f2b.md)
