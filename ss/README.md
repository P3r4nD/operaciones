# ss
```ss``` (socket statistics) es una herramienta para mostrar información sobre sockets en sistemas Linux. Reemplaza en gran medida a `netstat`, siendo más rápida y mostrando información más detallada sobre conexiones de red, puertos en escucha y procesos asociados.

- [ss](https://man7.org/linux/man-pages/man8/ss.8.html)

Sintaxis básica:

```ss [opciones] [filtro]```

## Tipos de sockets más comunes

```-t  ```
Sockets TCP

```-u```  
Sockets UDP

```-l  ```
Sockets en escucha (listening)

```-n ``` 
Muestra direcciones y puertos numéricos (no resuelve nombres)

```-p  ```
Muestra el proceso que usa el socket

## Ejemplos esenciales

### Mostrar todas las conexiones TCP
```
ss -t
```
### Mostrar conexiones UDP
```
ss -u
```
### Mostrar sockets en escucha
```
ss -l
```
### Mostrar sockets TCP en escucha con puertos y procesos
```
ss -tlnp
```
### Ver qué está escuchando en un puerto específico (ejemplo HTTPS 443)
```
ss -tulnp | grep :443
```
### Ver todos los puertos en escucha (TCP y UDP)
```
ss -tuln
```
### Mostrar conexiones establecidas
```
ss -tan state established
```
### Ver conexiones de un puerto concreto
```
ss -tan sport = :22
```
### Ver conexiones hacia un puerto concreto
```
ss -tan dport = :80
```
## Ejemplos enfocados a diagnóstico

### Ver procesos asociados a conexiones de red
```
ss -p
```
### Ver conexiones TCP con información detallada
```
ss -ti
```
### Filtrar conexiones por estado
```
ss state listening  
ss state established  
ss state time-wait
```
## Comparación rápida con netstat
```
ss -tulnp        # Equivalente a: netstat -tulnp  
ss -tan          # Equivalente a: netstat -tan  
```
## Notas importantes

- ```ss``` obtiene la información directamente del kernel, por lo que es más rápido que `netstat`.
- Algunas opciones requieren privilegios de superusuario para mostrar procesos.
- Es una herramienta clave para troubleshooting de red y servicios.

## Ver ayuda rápida
```
man ss
```
