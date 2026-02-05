# nc (netcat)
```nc``` es una herramienta de red que permite leer y escribir datos a través de conexiones TCP y UDP. Es conocida como la "navaja suiza" de la red y se usa para pruebas de conectividad, debugging de servicios, transferencia simple de datos y diagnóstico en incidentes.

- [netcat](https://man7.org/linux/man-pages/man1/nc.1.html)

Sintaxis básica:

```nc [opciones] host puerto```

También puede funcionar en modo escucha.

## Opciones más comunes

```-l  ```
Modo escucha (listen)

```-n  ```
No resuelve nombres DNS

```-v ``` 
Modo verboso

```-p puerto```  
Puerto local de origen

```-u```  
Usar UDP en lugar de TCP

```-z ``` 
Modo escaneo (no envía datos)

```-w segundos ``` 
Timeout de conexión

## Probar si un puerto está abierto en un host

```nc -zv servidor 443```

## Probar conectividad a un servicio web

```nc servidor 80```

## Ver si un servicio SSH responde

```nc -zv servidor 22```

## Escuchar en un puerto local

```nc -l 8080```

## Escuchar en un puerto con más detalles

```nc -lvnp 8080```

## Comprobar si un servicio está escuchando localmente

```nc -zv localhost 3306```

## Enviar texto manual a un servicio TCP

```nc servidor 25```

## Probar un endpoint HTTP de forma manual
```
nc servidor 80
GET / HTTP/1.1
Host: servidor
```
## Transferir un archivo entre dos hosts (simple)

En el receptor:
```nc -l 9000 > archivo.txt```

En el emisor:
```nc servidor 9000 < archivo.txt```

## Transferir un directorio comprimido

En el receptor:
```nc -l 9000 | tar xvf -```

En el emisor:
```tar cvf - directorio/ | nc servidor 9000```

## Escuchar tráfico UDP

```nc -lu 5000```

## Enviar datos por UDP

```echo "test" | nc -u servidor 5000```

## Ver si un puerto responde (sin depender de la app)  
```nc -zv servidor PUERTO```

Validar conectividad desde un contenedor o host mínimo  
```nc -zv destino 443```

Enviar logs rápidamente sin SCP  
```nc -l 9000 > logs.txt```

## Advertencias

- ```nc``` no cifra el tráfico
- No usar para transferir datos sensibles en redes no confiables
- Algunas versiones difieren (openbsd-netcat vs traditional)

## Ver ayuda rápida

```man nc```
