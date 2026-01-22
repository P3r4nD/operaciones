#!/bin/bash

# Archivo de log para registrar las acciones
LOG_FILE="/var/log/badips.log"

# Función para registrar mensajes en el log
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - TORIP-BLOCKS: $1" >> "$LOG_FILE"
}

# Nombre del conjunto ipset y archivo de entrada
IPSET_NAME="tor-ip-block"
INPUT_FILE="/etc/ipset-lists/tor-nodes.txt"

# Verificar si la regla de iptables existe
if ! /sbin/iptables -C INPUT -m set --match-set $IPSET_NAME src -j DROP 2>/dev/null; then
    log_message "La regla de iptables para '$IPSET_NAME' no existe. Procediendo con la configuración."

    # Verificar si el conjunto ipset existe
    /sbin/ipset list $IPSET_NAME > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        log_message "El conjunto '$IPSET_NAME' no existe. Creándolo ahora."
        /sbin/ipset create $IPSET_NAME hash:net
    else
        # El conjunto existe, comprobar si está vacío
        if /sbin/ipset list $IPSET_NAME | grep -q "Number of entries: 0"; then
            log_message "El conjunto '$IPSET_NAME' existe pero está vacío. Procediendo a llenarlo."
        else
            log_message "El conjunto '$IPSET_NAME' ya existe y no está vacío."
        fi
    fi

    # Llenar el conjunto ipset con las IPs del archivo
    while IFS= read -r IP; do
        if [ -n "$IP" ]; then
            /sbin/ipset -q -A $IPSET_NAME $IP
        fi
    done < "$INPUT_FILE"
    log_message "El conjunto '$IPSET_NAME' fue actualizado con éxito."

    # Insertar la regla en iptables
    /sbin/iptables -I INPUT 14 -m set --match-set $IPSET_NAME src -j DROP
    log_message "La regla de iptables para '$IPSET_NAME' fue insertada con éxito."
else
    log_message "La regla de iptables para '$IPSET_NAME' ya existe. No se realizaron cambios."
    echo "La regla de iptables para '$IPSET_NAME' ya existe. Saliendo del script."
    exit 0
fi
