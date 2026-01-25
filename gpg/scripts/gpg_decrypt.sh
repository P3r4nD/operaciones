#!/usr/bin/env bash

set -euo pipefail

# ./decrypt.sh <archivo|directorio> <destino>
# Ejemplo:
# ./decrypt.sh /ruta/cifrados /ruta/descifrados

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

# --- PEDIR PASSPHRASE ---
echo -n "Introduce la passphrase GPG: "
read -s PASSPHRASE
echo ""

decrypt_file() {
    local file="$1"
    local rel_path="$2"
    local out_dir="$DESTINO/$rel_path"

    mkdir -p "$out_dir"

    local filename
    filename=$(basename "$file")
    local output="${filename%.gpg}"

    echo "Descifrando: $file"

    gpg --batch --yes \
        --pinentry-mode loopback \
        --passphrase "$PASSPHRASE" \
        --output "$out_dir/$output" \
        --decrypt "$file"

    echo "→ $out_dir/$output"
}

if [[ -f "$ORIGEN" ]]; then
    decrypt_file "$ORIGEN" ""
else
    cd "$ORIGEN"
    find . -type f -name "*.gpg" | while read -r file; do
        rel_path=$(dirname "$file")
        decrypt_file "$ORIGEN/$file" "$rel_path"
    done
fi

echo "Proceso completado."
