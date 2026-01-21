#!/usr/bin/env python3

'''
Script para comprobar las actualizaciones de un entorno basado en Django,
así como de sus librerías y dependencias.
'''
import subprocess, json, sys
from datetime import datetime

def run(cmd):
    return subprocess.check_output(cmd, text=True).strip()

def parse_version(v):
    try:
        return tuple(map(int, v.split(".")))
    except Exception:
        return ()

print("==============================================")
print("   Informe de actualizaciones del entorno     ")
print("  ", datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
print("==============================================\n")

# --- Django ---
try:
    current = run(["pip", "show", "django", "--disable-pip-version-check"])
    current_version = [line.split()[1] for line in current.splitlines() if line.startswith("Version:")][0]
except subprocess.CalledProcessError:
    print("❌ Django no está instalado.\n")
    current_version = None

if current_version:
    outdated = run(["pip", "list", "--outdated", "--disable-pip-version-check", "--format=json"])
    pkgs = json.loads(outdated) if outdated else []
    latest = next((p["latest_version"] for p in pkgs if p["name"].lower() == "django"), current_version)

    print("🔍 Django:")
    print(f"   Instalado: {current_version}")
    print(f"   Última versión disponible: {latest}")
    if current_version != latest:
        print("⚠ Django está desactualizado.\n")
    else:
        print("✅ Django está al día.\n")

# --- pip ---
current_pip = run(["pip", "--disable-pip-version-check", "--version"]).split()[1]
try:
    versions_text = run(["pip", "index", "versions", "pip"])
    latest_pip = versions_text.split("Available versions:")[1].split(",")[0].strip()
except Exception:
    latest_pip = current_pip

print("📦 pip:")
print(f"   Instalado: {current_pip}")
print(f"   Última versión disponible: {latest_pip}")
if current_pip != latest_pip:
    print("⚠ pip está desactualizado.\n")
else:
    print("✅ pip está al día.\n")

# --- librerías ---
outdated = run(["pip", "list", "--outdated", "--disable-pip-version-check", "--format=json"])
pkgs = json.loads(outdated) if outdated else []

print("📦 Librerías desactualizadas:")
if not pkgs:
    print("✅ Todas las librerías están al día.")
else:
    print(f"{'Package':<20} {'Installed':<12} {'Latest':<12} {'Nivel'}")
    print("-"*60)

    for pkg in pkgs:
        name, current, latest = pkg["name"], pkg["version"], pkg["latest_version"]
        c, l = parse_version(current), parse_version(latest)
        nivel = "❓ Desconocido"

        if c and l:
            if l[0] > c[0]:
                nivel = "🔴 MAJOR (riesgo alto)"
            elif len(l) > 1 and l[1] > c[1]:
                nivel = "🟠 MINOR (riesgo medio)"
            elif len(l) > 2 and l[2] > c[2]:
                nivel = "🟢 PATCH (seguro)"
            else:
                nivel = "✅ Igual versión"

        flag = " (CRÍTICO)" if name.lower() == "django" else ""
        print(f"{name:<20} {current:<12} {latest:<12} {nivel}{flag}")
