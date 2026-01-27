# ping
Herramienta para comprobar mediante protocolo [ICMP] la conectividad de dispositivos en red.
- [ping](https://man.cx/ping)
## Ping a una dirección IP
```
ping 1.1.1.1
```

## Ping a un dominio
```
ping www.cloudflare.com
```

## Limitar número de paquetes
```
ping -c 5 cloudflare.com
```

## Ping con tamaño de paquete personalizado
```
ping -s 1000 192.168.1.1
```

## Ping con intervalo entre paquetes
```
ping -i 2 www.google.com
```

## Ping guardando resultados en un archivo
```
ping -c 10 www.google.com > resultados.txt
```

## Ping continuo con timestamp y guardando resultados
```
while true; do date; ping -c 1 www.google.com; sleep 5; done >> ping_log.txt
```

## Ping viendo solo la latencia
```
ping -D www.google.com
```
