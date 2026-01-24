# GPG (GNU Privacy Guard)

## Crear una clave GPG segura para cifrar datos en un servidor remoto 

```gpg --full-generate-key```

- **Tipo de clave:** ```RSA``` and ```RSA```
- **Tamañom recomendado:** ```4096```
- **Caducidad:** ```2y```
- **Nombre y email:** Como identificadores
- **Passphrase::** Contraseña de la llave

## Verificar la clave creada

```bash
gpg --list-keys 
gpg --list-secret-keys
```

El ```fingerprint```identifica ambas llaves:
```207F1F0EFE947C88FA73B0A6E51BBE3A4B6C9627```

## Exportar la clave pública y copiarla en un servidor remoto

### Exportar en local
```bash
gpg --export -a "email@xample.com" > public.key
```

### Copiar en servidor remoto
```bash
scp public.key usuario@servidor:/tmp/public.key
```

### Conectarse al servidor e importar la clave pública

```ssh -p 2222 usuario@servidor```

```gpg --import /tmp/public.key```

#### Verificar

```gpg --list-keys```

#### Establecer confianza en la clave (opcional)

```bash
gpg --edit-key email@xample.com
```

En el prompt:

```
trust
5
y
quit
```

## Cifrar archivos manualmente

```bash
gpg --yes --trust-model always --recipient "email@xample.com" --encrypt archivo.txt
```

## Descifrar

```bash
gpg --decrypt archivo.txt.gpg > archivo.txt
```
