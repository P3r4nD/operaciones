# Network

## Script para detectar fallos en la interfaz de red y/o pérdida de conectividad
Este script, ejecutado automáticamente cada minuto mediante systemd y un timer, supervisa el estado de la conectividad de red y genera un informe detallado cuando detecta un fallo.
Su propósito es capturar toda la información relevante en el momento del problema para facilitar el diagnóstico.
[network-outage-logger](scripts/network-outage-logger.sh)

Cuando aparecen errores de conectividad copiamos y habilitamos:
- El servicio [network-monitor.service](scripts/network-monitor.service) en ```/etc/systemd/system/network-monitor.service```
- El timer [network-monitor.timer](scripts/network-monitor.timer) en ```/etc/systemd/system/network-monitor.timer```

| Sección                           | Descripción                                                                 |
|-----------------------------------|-----------------------------------------------------------------------------|
| **FECHA**                         | Fecha y hora exactas del fallo                                              |
| **IP ADDR**                       | Configuración de direcciones IP de todas las interfaces                     |
| **IP LINK**                       | Estado de los enlaces de red                                                |
| **IP ROUTE**                      | Tabla de rutas del sistema                                                  |
| **ETHTOOL**                       | Información física de cada interfaz (velocidad, duplex, link, etc.)         |
| **NMCLI GENERAL**                 | Estado general de NetworkManager                                            |
| **NMCLI DEVICE STATUS**           | Estado de cada dispositivo gestionado por NetworkManager                    |
| **NMCLI CONEXIONES ACTIVAS**      | Conexiones activas en ese momento                                           |
| **JOURNALCTL (últ. 10 min)**      | Logs recientes de NetworkManager, systemd-networkd y wpa_supplicant         |
| **JOURNAL KERNEL (últ. 10 min)**  | Mensajes recientes del kernel                                               |
| **DMESG RECIENTE**                | Últimas 100 líneas de `dmesg`                                               |

---
## Comandos para habilitar el servicio y el timer de systemd

**1. Recargar systemd para detectar las nuevas unidades**
```bash
sudo systemctl daemon-reload
``` 
**2. Habilitar y arrancar el timer (el que ejecuta el script cada minuto)**
```bash
sudo systemctl enable --now network-monitor.timer
``` 
**3. Comprobar el estado del timer**
```bash
systemctl status network-monitor.timer
``` 
**4. Ejecutar el servicio manualmente (opcional, para pruebas)**
```bash
sudo systemctl start network-monitor.service
``` 
**5. Ver la lista de timers activos y próximos disparos**
```bash
systemctl list-timers --all
``` 
