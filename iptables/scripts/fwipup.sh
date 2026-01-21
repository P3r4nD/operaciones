#!/bin/bash

# ------------------------
# Configuración
# ------------------------
PORT=""
NOIP_DOMAIN="xxxxx.ddns.net"
OPERATOR=""
ALLOWED_IPS_FILE="/root/allowedips.txt"

# ------------------------
# Obtener IP actual del dominio NOIP
# ------------------------
IP_NOIP=$(dig +short "$NOIP_DOMAIN" | tail -n1)

if [[ -z "$IP_NOIP" ]]; then
    echo "Error: No se pudo resolver la IP de $NOIP_DOMAIN"
    exit 1
fi

echo "IP obtenida de $NOIP_DOMAIN: $IP_NOIP"

# ------------------------
# Busca la IP en ALLOWED_IPS_FILE
# ------------------------

if grep -q "$IP_NOIP" "$ALLOWED_IPS_FILE" 2>/dev/null; then
    echo "La IP $IP_NOIP ya está registrada en $ALLOWED_IPS_FILE. No se realizan cambios."
    exit 0
fi

# ------------------------
# Validar que la IP pertenece al operador esperado
# ------------------------
HOSTNAME=$(host "$IP_NOIP" | awk '{print $5}' | sed 's/\.$//')

if [[ "$HOSTNAME" != *"$OPERATOR"* ]]; then
    echo "Error: La IP $IP_NOIP no pertenece a $OPERATOR (hostname detectado: $HOSTNAME)"
    exit 1
fi

echo "Validación correcta: $IP_NOIP pertenece a $OPERATOR ($HOSTNAME)"

# ------------------------
# Eliminar la última IP de iptables (la que añadimos anteriormente)
# ------------------------
if [[ -f "$ALLOWED_IPS_FILE" && -s "$ALLOWED_IPS_FILE" ]]; then
    LAST_IP=$(tail -n1 "$ALLOWED_IPS_FILE" | awk '{print $NF}')
    if [[ -n "$LAST_IP" ]]; then
        /sbin/iptables -D INPUT -p tcp --dport "$PORT" -s "$LAST_IP" -j ACCEPT 2>/dev/null  || \
        echo "Advertencia: no se pudo eliminar la regla anterior ($LAST_IP), probablemente no existía"
    fi
fi

# ------------------------
# Insertar la nueva regla
# ------------------------
if /sbin/iptables -C INPUT -p tcp --dport "$PORT" -s "$IP_NOIP" -j ACCEPT 2>/dev/null; then
    echo "La regla para $IP_NOIP ya existe en iptables, no se inserta de nuevo"
else
    /sbin/iptables -I INPUT -p tcp --dport "$PORT" -s "$IP_NOIP" -j ACCEPT
    if [[ $? -ne 0 ]]; then
        echo "Error: No se pudo insertar la regla en iptables"
        exit 1
    fi
    echo "Regla actualizada: SSH en puerto $PORT permitido solo para $IP_NOIP"
fi

# ------------------------
# Registrar la nueva IP en allowed_ips.txt
# ------------------------
DATE_NOW=$(date '+%Y-%m-%d %H:%M:%S')
echo "$DATE_NOW - $IP_NOIP" >> "$ALLOWED_IPS_FILE"
echo "Nueva IP registrada en $ALLOWED_IPS_FILE"

SUBJECT="Firewall: Regla SSH actualizada"
TO="example @ domain . com"
BODY="La regla SSH ($IP_NOIP) se actualizó correctamente en el puerto $PORT."

echo "$BODY" | mail -s "$SUBJECT" "$TO"
