# Cuenta de MaxMind y las claves de licencia

Crear cuenta gratuita en:
https://www.maxmind.com/en/geolite2/signup

Obtener:
- **Account ID**
- **License Key**

---

## Instalar `geoipupdate`

El script depende del binario `/usr/bin/geoipupdate`.

### Debian/Ubuntu
```bash
sudo apt update
sudo apt install geoipupdate
```
### CentOS/RHEL
```bash
sudo yum install geoipupdate
```
### Arch Linux
```
sudo pacman -S geoipupdate
```
### AlmaLinux y Rocky Linux
```bash
sudo dnf install geoipupdate
```
## Verificar ruta y binario
```/usr/share/GeoIP``` (Para bases de datos)

```/usr/bin/geoipupdate``` (Binario)
## Configuración GeoIP

Configurar ```/etc/GeoIP.conf``` o ```/etc/GeoIP/GeoIP.conf``` según distro.

```bash
AccountID 123456
LicenseKey ABCDEFGHIJKLMNOP
EditionIDs GeoLite2-ASN GeoLite2-City GeoLite2-Country
```
## Primera ejecución
```bash
# Si verbose mode
sudo geoipupdate -v

# O ejecución normal
sudo geoipupdate

# Verificar bases de datos
ls -l /usr/share/GeoIP/
```

