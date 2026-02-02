# scp
https://man.openbsd.org/scp

## Descripción

```scp``` (secure copy) es un comando de sistemas Unix/Linux que permite copiar archivos y directorios entre equipos a través de una conexión segura usando SSH. Los datos viajan cifrados, lo que lo hace adecuado para transferencias en redes no confiables.

Sintaxis básica:
```
scp [opciones] origen destino
```
El origen y/o destino pueden ser locales o remotos.

## Formato de rutas remotas
```
usuario@host:/ruta/al/archivo
```
Ejemplo:
```
usuario@servidor:/home/usuario/archivo.txt
```
## Ejemplos esenciales

### Copiar un archivo local a un servidor remoto
```bash
scp archivo.txt usuario@servidor:/home/usuario/
```
### Copiar un archivo desde un servidor remoto al equipo local
```
scp usuario@servidor:/home/usuario/archivo.txt .
```
### Copiar y renombrar un archivo en el destino
```
scp archivo.txt usuario@servidor:/home/usuario/archivo_nuevo.txt
```
### Copiar un directorio completo (recursivo)
```
scp -r directorio/ usuario@servidor:/home/usuario/
```
### Copiar un directorio remoto al equipo local
```
scp -r usuario@servidor:/home/usuario/directorio/ .
```
## Opciones más usadas

```-r```
Copia directorios de forma recursiva.

```-p```
Preserva permisos, fechas y tiempos del archivo original.

```-P puerto```  
Especifica un puerto SSH distinto del 22.

```-C```  
Habilita compresión durante la transferencia.
```
-v
```
Modo verboso, útil para depuración.

## Ejemplos con opciones

### Copiar usando un puerto SSH personalizado
```
scp -P 2222 archivo.txt usuario@servidor:/home/usuario/
```
### Copiar mostrando detalles del proceso
```
scp -v archivo.txt usuario@servidor:/home/usuario/
```
### Copiar preservando permisos y fechas
```
scp -p archivo.txt usuario@servidor:/home/usuario/
```
## Notas importantes

- ```cp``` requiere acceso SSH al equipo remoto.
- A partir de OpenSSH recientes, `scp` usa internamente SFTP.
- Para transferencias complejas o sincronización frecuente, puede ser preferible usar `rsync`.

## Ver ayuda rápida
```
man scp
```
