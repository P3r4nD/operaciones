# dpkg
La herramienta dpkg es la base del sistema de gestión de paquetes de Debian GNU/Linux
- [dpkg](https://man.cx/dpkg)
## Listar kernels
```
dpkg --list | grep linux-image
```
## Identificar kernel en uso
```
uname -a
```
## Eliminar kernels antiguos
```
sudo apt remove --purge linux-image-<versión>-generic
```
## Limpiar paquetes adicionales
```
sudo apt autoremove --purge
sudo update-grub
```
