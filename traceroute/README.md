# traceroute
Herramienta de diagnóstico de red que permite rastrear la ruta que siguen los paquetes IP desde una máquina hasta un destino específico
- [traceroute](https://man.cx/traceroute)
## Diagnóstico de conectividad
```
traceroute google.com
```
## Evitar resolución DNS para acelerar la salida
```
traceroute -n facebook.com
```
## Visualización del recorrido de los paquetes
```
traceroute -m 30 wikipedia.org
```
## Uso de TCP para sortear filtros o probar puertos específicos
```
traceroute -T -p 443 cloudflare.com
```
- ```-T``` usa TCP SYN en lugar de UDP/ICMP.
## Forzar uso de IPv4
```
traceroute -4 internal-server.local
```
## Usar ICMP en lugar de UDP
```traceroute -I example.com```
## Cambiar número de probes por salto
```traceroute -q 1 example.com ```
## Cambiar tamaño del paquete
```traceroute -s 60 example.com```
## Verificar configuración
 - ```traceroute -I``` (ICMP)
 - ```traceroute -T``` (TCP)
 - ```traceroute6``` (IPv6)
## Ajustando tiempo de espera
```
traceroute -w 2 bing.com
```
