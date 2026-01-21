# No-IP

**No-IP** es un servicio de **DNS dinámico (DDNS)** que permite asociar un nombre de dominio a una dirección IP que cambia con frecuencia, como ocurre en la mayoría de conexiones domésticas o pequeñas oficinas.

---

## 🧩 ¿Para qué sirve?

- Permite acceder a un servidor, NAS, dispositivo IP o servicio alojado en una red con **IP pública dinámica**.
- Evita tener que comprobar manualmente la IP cada vez que cambia.
- Mantiene un **dominio actualizado automáticamente** con la IP actual del dispositivo.

---

## ⚙️ Instalación

1. Creas un **hostname** en [No-IP](https://www.noip.com/es-MX) (ejemplo: `midominio.ddns.net`).
2. Instalas el **cliente DUC (Dynamic Update Client)** en tu máquina o router.
```bash
wget --content-disposition https://www.noip.com/download/linux/latest
tar xf noip-duc_3.3.0.tar.gz
cd /home/$USER/noip-duc_3.3.0/binaries && sudo apt install ./noip-duc_3.3.0_amd64.deb
```
## ⚙️ Crear archivo de configuración
Con las crdenciales de NOIP
```bash
sudo nano /etc/default/noip-duc
```
Contenido
```bash
NOIP_USERNAME="tu_usuario_noip"
NOIP_PASSWORD="tu_password_noip"
NOIP_HOSTNAMES="xxxxx.ddns.net"
```
## Crear system service
```bash
sudo nano /etc/systemd/system/noip-duc.service
```
Contenido
```bash
[Unit]
Description=No-IP Dynamic Update Client
After=network.target auditd.service

[Service]
EnvironmentFile=/etc/default/noip-duc
ExecStart=/usr/bin/noip-duc --check-interval 5m
Restart=always
Type=simple

[Install]
WantedBy=multi-user.target
```
## Recargar ```systemd```
```bash
sudo systemctl daemon-reload
```
## Activar, Iniciar y Verificar servicio
```bash
sudo systemctl enable noip-duc.service

sudo systemctl start noip-duc.service

sudo systemctl status noip-duc.service

ping midominio.ddns.net (debería devolver la IP actualizada con la tuya local)
```
## Ver los logs del servicio
```bash
journalctl -u noip-duc.service -f
```
---
## 🛠️ Componentes principales

- **Hostname DDNS**  
  Nombre de dominio que apunta a tu IP dinámica.

- **DUC (Dynamic Update Client)**  
  Programa que envía la IP actual a No-IP.

- **Panel de control web**  
  Permite gestionar hostnames, dominios y configuraciones.

---

## 🎯 Casos de uso típicos

- Acceso remoto a:
  - Servidores SSH
  - Servidores web
  - NAS (Synology, QNAP…)
  - Cámaras IP
  - Servicios caseros (Home Assistant, Pi-hole, etc.)

- Sustituir la necesidad de una IP fija.

---

## 📝 Notas importantes

- En la versión gratuita, No-IP requiere **confirmar el hostname cada 30 días**.
- Algunos routers incluyen soporte DDNS integrado para No-IP, sin necesidad del cliente DUC.

