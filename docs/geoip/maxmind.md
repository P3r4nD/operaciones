# Cuenta de MaxMind y las claves de licencia

Crear cuenta gratuita en:
https://www.maxmind.com/en/geolite2/signup

Obtener:
- **Account ID**
- **License Key**

---

## Instalar `geoipupdate`

El script depende del binario `/usr/bin/geoipupdate`, que se instala desde los repositorios oficiales.

### Debian/Ubuntu

```bash
sudo apt update
sudo apt install geoipupdate

Configurar ```/etc/GeoIP.conf``` o ```/etc/GeoIP/GeoIP.conf``` según distro.

```bash
AccountID 123456
LicenseKey ABCDEFGHIJKLMNOP
EditionIDs GeoLite2-ASN GeoLite2-City GeoLite2-Country
```
