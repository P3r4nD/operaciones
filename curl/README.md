# curl
```curl``` es una herramienta de línea de comandos para transferir datos desde o hacia un servidor usando múltiples protocolos, principalmente HTTP y HTTPS. Es fundamental para probar APIs, depurar servicios web, validar certificados TLS y comprobar conectividad desde sistemas mínimos.

-[curl](https://curl.se/docs/manpage.html)

Sintaxis básica:

```curl [opciones] URL```

## Opciones más comunes

```-X``` METODO  
Especifica el método HTTP (GET, POST, PUT, DELETE, etc.)

```-I```  
Muestra solo las cabeceras de la respuesta

```-v```  
Modo verboso (debug de conexión y TLS)

```-s ``` 
Modo silencioso (no muestra barra de progreso)

```-k ``` 
Ignora errores de certificados TLS (no recomendado en producción)

```-H  ```
Añade cabeceras HTTP

```-d  ```
Envía datos en una petición (POST/PUT)

```-o archivo```  
Guarda la salida en un archivo

```-L ``` 
Sigue redirecciones

## Ejemplos esenciales

### Hacer una petición GET simple

```curl https://example.com```

### Ver solo las cabeceras HTTP

```curl -I https://example.com```

### Ver petición y respuesta completa (debug)

```curl -v https://example.com```

### Seguir redirecciones

```curl -L http://example.com```

### Guardar respuesta en un archivo

```curl -o pagina.html https://example.com```

## Ejemplos para APIs

### Petición GET con cabeceras

```curl -H "Authorization: Bearer TOKEN" https://api.example.com/data```

### Petición POST con JSON
```bash
curl -X POST https://api.example.com/items \
-H "Content-Type: application/json" \
-d '{"name":"test","value":123}'
```
### Petición PUT
```bash
curl -X PUT https://api.example.com/items/1 \
-H "Content-Type: application/json" \
-d '{"name":"updated"}'
```
### Petición DELETE

```curl -X DELETE https://api.example.com/items/1```

## Ejemplos de troubleshooting

### Comprobar conectividad HTTPS y TLS

```curl -v https://servidor```

### Probar un endpoint desde un contenedor

```curl -s https://servidor/health```

### Ver código de estado HTTP

```curl -o /dev/null -s -w "%{http_code}\n" https://servidor```

### Medir tiempos de respuesta

```curl -o /dev/null -s -w "DNS:%{time_namelookup} Connect:%{time_connect} TLS:%{time_appconnect} TTFB:%{time_starttransfer} Total:%{time_total}\n" https://servidor```

## Autenticación

### Basic Auth

```curl -u usuario:password https://servidor```

### Token en cabecera

```curl -H "Authorization: Bearer TOKEN" https://servidor```

## Descargas

### Descargar un archivo

```curl -O https://example.com/archivo.tar.gz```

### Reanudar una descarga

```curl -C - -O https://example.com/archivo.tar.gz```

## Notas importantes

- `curl` está disponible prácticamente en cualquier sistema Unix/Linux
- Es ideal para pruebas rápidas sin necesidad de clientes gráficos
- `-k` solo debe usarse en entornos de prueba
- Para flujos complejos, considerar scripts o herramientas como `httpie`

## Ver ayuda rápida

```man curl```
