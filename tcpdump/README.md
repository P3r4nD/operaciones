# tcpdump

```sudo tcpdump```

## Mostrar interfaces
```tcpdump -D```

```sudo tcpdump -i eth0```

## Ver tráfico hacia/desde una IP específica

```sudo tcpdump host 192.168.1.10```

## Solo como origen

```sudo tcpdump src host 192.168.1.10```

## Solo como destino

```sudo tcpdump dst host 192.168.1.10```

## Ver tráfico por puerto (por ejemplo, HTTP)

```sudo tcpdump port 80```

## Puerto origen

```sudo tcpdump src port 80```

## Puerto destino

```sudo tcpdump dst port 80```

## Por protocolos
```bash
sudo tcpdump tcp
sudo tcpdump udp
sudo tcpdump icmp
```
## Ver tráfico entre dos IPs específicas

```sudo tcpdump host 192.168.1.10 and host 192.168.1.20```

## Ver tráfico entre IP y puerto

```sudo tcpdump host 192.168.1.10 and port 22```

## Capturar a archivo .pcap

```sudo tcpdump -i eth0 -w captura.pcap```

## Mostrar datos en hexadecimal y ASCII:

```sudo tcpdump -X -i eth0```

## Mostrar solo primeros N paquetes:

```sudo tcpdump -c 10```

## Evitar tráfico propio de tcpdump/ssh (útil en sesiones remotas)

```sudo tcpdump not port 22```

