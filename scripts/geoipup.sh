#!/bin/bash

# Requerimientos https://github.com/P3r4nD/operaciones/blob/main/docs/geoip/maxmind.md

# Configuración
GEOIP_DIR="/usr/share/GeoIP"
DEST_DIR="/home/usuariox/GeoIP-DB/geofiles"
USER="usuariox"
GROUP="usuariox"

# Ejecutar geoipupdate
echo "Iniciando actualización de GeoIP..."
/usr/bin/geoipupdate

if [ $? -eq 0 ]; then
    echo "GeoIP update ejecutado con éxito en: $(date)"
else
    echo "Error al ejecutar geoipupdate. Revisa los registros para más detalles."
    exit 1
fi

# Archivos que se deben copiar
FILES=("GeoLite2-ASN.mmdb" "GeoLite2-City.mmdb" "GeoLite2-Country.mmdb")

# Copiar los archivos actualizados y asignar permisos
for FILE in "${FILES[@]}"; do
    if [ -f "$GEOIP_DIR/$FILE" ]; then
        echo "Copiando $FILE a $DEST_DIR..."
        cp "$GEOIP_DIR/$FILE" "$DEST_DIR/"

        if [ $? -eq 0 ]; then
            echo "Archivo $FILE copiado con éxito."
            # Asignar permisos
            chown "$USER:$GROUP" "$DEST_DIR/$FILE"
            chmod 644 "$DEST_DIR/$FILE"
            echo "Permisos asignados a $FILE: Propietario $USER, Grupo $GROUP, Permisos 644."
        else
            echo "Error al copiar $FILE."
        fi
    else
        echo "Archivo $FILE no encontrado en $GEOIP_DIR. Omitiendo."
    fi
done

echo "Proceso completado."
