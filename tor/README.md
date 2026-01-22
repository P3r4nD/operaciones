# TOR - The Onion Routing

## Actualizar lista local de nodos TOR
Esto se ejecuta meidante ```cron``` o ```systemd```
```bash
#!/bin/bash -l

# Lugar donde se guardará la lista actualizada
OUTPUT_FILE="/etc/ipset-lists/tor-nodes.txt"

# Obtener la lista de IPs de los nodos de salida de Tor y guardarla en el archivo
curl -sSL "https://check.torproject.org/torbulkexitlist" | sed '/^#/d' > "$OUTPUT_FILE"

echo "La lista de nodos de salida de Tor ha sido actualizada en $OUTPUT_FILE."
