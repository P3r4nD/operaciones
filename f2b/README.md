# Fail2Ban

## Configuración global
```sudo fail2ban-client -d```

## Ver los jails activos
```sudo fail2ban-client status```

## Configuración completa de un jail
```sudo fail2ban-client status http-400```

## Ver los parámetros internos del jail
```sudo fail2ban-client get http-400```

### Obtener parámetros completos
```
sudo fail2ban-client get http-400 bantime
sudo fail2ban-client get http-400 maxretry
sudo fail2ban-client get http-400 logpath
sudo fail2ban-client get http-400 port
```
## Ver el filtro que está usando un jail
```sudo fail2ban-client get http-400 filter```

### Configuración del filtro
```sudo cat /etc/fail2ban/filter.d/http-400.conf```

## Depurar las regex cargadas en un filtro
```sudo fail2ban-regex /var/log/nginx/access.log /etc/fail2ban/filter.d/http-400.conf```

## Ver IPs bloqueadas por un jail
```sudo fail2ban-client status http-400```

## Banear IP
```sudo fail2ban-client set http-400 banip 1.2.3.4```

## Unbanear IP
```sudo fail2ban-client set http-400 unbanip 1.2.3.4```

## Banear una IP en todos los jails
```
for jail in $(sudo fail2ban-client status | grep 'Jail list' | cut -d: -f2 | tr ',' ' '); do
    sudo fail2ban-client set $jail banip 1.2.3.4
done
```
