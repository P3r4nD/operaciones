# Network

## Script para detectar fallos en la interfaz de red y/o pérdida de conectividad
Este script, ejecutado automáticamente cada minuto mediante systemd y un timer, supervisa el estado de la conectividad de red y genera un informe detallado cuando detecta un fallo.
Su propósito es capturar toda la información relevante en el momento del problema para facilitar el diagnóstico.
[network-outage-logger](scripts/network-outage-logger.sh)

Cuando aparecen errores de conectividad copiamos y habilitamos:
- El servicio [network-monitor.service](scripts/network-monitor.service) en ```/etc/systemd/system/network-monitor.service```
- El timer [network-monitor.timer](scripts/network-monitor.timer) en ```/etc/systemd/system/network-monitor.timer```

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
