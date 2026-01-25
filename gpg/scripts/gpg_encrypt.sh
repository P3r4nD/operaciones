#!/usr/bin/env bash

set -euo pipefail

# --- CONFIGURACIÓN ---
RECIPIENT="email@xample.com"

# ./gpg_encrypt.sh <origen> <destino>
# Ejemplo:
# ./gpg_encrypt.sh /ruta/datos /ruta/cifrados

if [[ $# -ne 2 ]]; then
    echo "Uso: $0 <archivo|directorio> <destino>"
    exit 1
fi

ORIGEN="$1"
DESTINO="$2"

if [[ ! -e "$ORIGEN" ]]; then
    echo "Error: el origen no existe."
    exit 1
fi

mkdir -p "$DESTINO"

encrypt_file() {
    local file="$1"
    local rel_path="$2"
    local out_dir="$DESTINO/$rel_path"

    mkdir -p "$out_dir"

    local filename
    filename=$(basename "$file")

    gpg --yes --trust-model always \
        --recipient "$RECIPIENT" \
        --output "$out_dir/$filename.gpg" \
        --encrypt "$file"

    echo "Cifrado: $file → $out_dir/$filename.gpg"
}

if [[ -f "$ORIGEN" ]]; then
    encrypt_file "$ORIGEN" ""
else
    cd "$ORIGEN"
    find . -type f | while read -r file; do
        rel_path=$(dirname "$file")
        encrypt_file "$ORIGEN/$file" "$rel_path"
    done
fi

echo "Proceso completado."
