## Detección de shells inversas en Linux (in progress)

Esta sección describe técnicas prácticas para detectar shells inversas activas
mediante análisis de conexiones de red y procesos locales.

El objetivo es identificar:
- conexiones salientes sospechosas
- shells asociadas a sockets de red
- procesos sin TTY
- tráfico interactivo anómalo

---

## Detección con ss

### Ver conexiones TCP salientes establecidas

```ss -tan state established```

Indicadores sospechosos:
- conexiones persistentes a IPs externas
- puertos no estándar (no 80, 443, 22)
- sesiones largas sin tráfico HTTP aparente

---

### Ver procesos asociados a conexiones de red

```ss -tanp```

Buscar:
- procesos tipo sh, bash, dash, zsh
- intérpretes de scripting con sockets abiertos
- procesos de comandos con conexión activa

Ejemplo de patrón sospechoso:
bash con conexión TCP establecida hacia una IP externa

---

### Ver solo conexiones salientes (no listening)

```ss -tan | grep ESTAB```

Útil para:
- servidores que normalmente no generan tráfico saliente
- detección rápida en incidentes

---

## Detección con netstat (sistemas legacy)

### Ver conexiones establecidas con procesos

```netstat -tanp```

Indicadores:
- procesos de shell asociados a conexiones externas
- puertos remotos altos o inusuales

---

### Ver solo conexiones TCP establecidas

```netstat -tan | grep ESTABLISHED```

Comparar:
- IPs remotas
- duración de la conexión
- patrón de puertos

---

## Detección con ps

Las shells inversas suelen ejecutarse:
- sin TTY
- como procesos hijos inesperados
- con stdin/stdout redirigidos

---

### Buscar shells sin terminal asociada

```ps aux | grep -E "bash|sh|dash|zsh"```

Indicador clave:
shell activa sin columna TTY (por ejemplo: ?)

---

### Ver árbol de procesos

```ps -ef --forest```

Buscar:
- shells hijas de procesos no interactivos
- procesos lanzados desde servicios, cron o demonios
- cadenas de procesos inusuales

---

### Ver detalles de descriptores (opcional)

```ls -l /proc/<PID>/fd```

Indicadores:
- descriptores apuntando a sockets
- stdin/stdout conectados a red en lugar de TTY

---

## Detección con tcpdump

tcpdump permite detectar shells inversas observando el patrón del tráfico.

---

### Capturar tráfico TCP interactivo

```tcpdump -i any tcp```

Indicadores:
- paquetes pequeños
- intercambio rápido de ida y vuelta
- ausencia de protocolo de aplicación reconocible

---

### Filtrar por host remoto sospechoso

```tcpdump -i any host X.X.X.X```

Útil cuando:
- una IP externa ya fue identificada con ss/netstat

---

### Filtrar por puerto sospechoso

```tcpdump -i any port 4444```

Buscar:
- tráfico continuo
- sesiones largas
- payloads pequeños (comandos)

---

### Ver contenido en texto (entornos controlados)

```tcpdump -i any -A tcp```

Indicador típico:
tráfico ASCII interactivo sin cabeceras HTTP

---

## Correlación recomendada

1. Identificar conexión sospechosa con ss/netstat
2. Obtener PID asociado
3. Analizar proceso con ps
4. Confirmar patrón con tcpdump
5. Aislar o cortar la conexión

---

## Señales claras de alerta

- shell activa sin usuario interactivo
- proceso de comandos con socket TCP abierto
- conexión saliente persistente desde servidor
- tráfico interactivo sin protocolo definido

---

## Buenas prácticas

- monitorear tráfico saliente
- registrar conexiones establecidas
- alertar ante shells sin TTY
- combinar detección de red y procesos

Esta detección es válida tanto para:
- respuesta a incidentes
- validación de controles de seguridad
- ejercicios blue team
- pentesting autorizado
