#!/bin/bash

# === CONFIGURACIÓN ===
LOGDIR="/var/log/network-failures"
TIMESTAMP=$(date "+%Y%m%d-%H%M%S")
LOGFILE="$LOGDIR/failure-$TIMESTAMP.log"
TESTHOST="1.1.1.1"

# === CREA DIRECTORIO DE LOGS SI NO EXISTE ===
mkdir -p "$LOGDIR"

# === PRUEBA DE CONECTIVIDAD ===
ping -c 2 -W 3 $TESTHOST > /dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "=============================================================================="
  echo "[!] Fallo de conectividad detectado a las $TIMESTAMP. Guardando diagnóstico..." | tee -a "$LOGFILE"
  echo "=============================================================================="

  {
    echo "=============================================================================="
    echo "===== FECHA ====="
    date
    echo
    echo "===== IP ADDR ====="
    ip addr
    echo
    echo "===== IP LINK ====="
    ip link
    echo
    echo "===== IP ROUTE ====="
    ip route
    echo
    echo "===== ETHTOOL ====="
    for IF in $(ls /sys/class/net/); do
      echo "--- $IF ---"
      ethtool "$IF" 2>/dev/null || echo "ethtool no disponible o interfaz inválida"
    done
    echo
    echo "===== NMCLI GENERAL ====="
    nmcli general
    echo
    echo "===== NMCLI DEVICE STATUS ====="
    nmcli device status
    echo
    echo "===== NMCLI CONEXIONES ACTIVAS ====="
    nmcli connection show --active
    echo
    echo "===== JOURNALCTL (últimos 10 min) ====="
    journalctl -u NetworkManager -u systemd-networkd -u wpa_supplicant --since "10 minutes ago"
    echo
    echo "===== JOURNAL DEL KERNEL (últimos 10 min) ====="
    journalctl -k --since "10 minutes ago"
    echo
    echo "===== DMESG RECIENTE ====="
    dmesg --ctime | tail -n 100
    echo "=============================================================================="
  } >> "$LOGFILE"
else
  echo "[OK] Red funcional a las $TIMESTAMP"
fi
