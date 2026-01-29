# systemctl
Herramienta para gestionar el sistema de inicio y los servicios de systemd
- [systemctl](https://man.cx/systemctl)
## Iniciar servicio
```systemctl start nombre-servicio```
## Detener servicio
```systemctl stop nombre-servicio```
## Reiniciar servicio
```systemctl restart nombre-servicio```
## Recargar configuración sin reiniciar
```systemctl reload nombre-servicio```
## Ver el estado de un servicio
```systemctl status nombre-servicio```
## Habilitar un servicio al arranque
```systemctl enable nombre-servicio```
## Deshabilitar un servicio
```systemctl disable nombre-servicio```
## Ver todos los servicios
```systemctl list-units --type=service```
## Ver servicios habilitados al arranque
```systemctl list-unit-files --type=service```
## Ver logs de un servicio (journalctl)
- [journalctl](/journalctl)
```journalctl -u nombre-servicio```
