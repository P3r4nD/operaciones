                         ┌───────────────────────────────┐
                         │            Cliente             │
                         │        Navegador Web           │
                         └───────────────┬───────────────┘
                                         │ HTTP/HTTPS
                                         ▼
                         ┌────────────────────────────────┐
                         │             NGINX               │
                         │   Proxy inverso / Servidor web │
                         └───────────────┬────────────────┘
                                         │ Proxy (uwsgi/http)
                                         ▼
                         ┌────────────────────────────────┐
                         │            Gunicorn             │
                         │   WSGI Server para Django      │
                         └───────────────┬────────────────┘
                                         │ Llama a la app
                                         ▼
                         ┌────────────────────────────────┐
                         │     Django + entorno virtual    │
                         │  (venv con dependencias Python) │
                         └───────────────┬────────────────┘
                                         │ Usa settings.py
                                         ▼
                         ┌────────────────────────────────┐
                         │      Base de Datos PostgreSQL   │
                         │   (Consultas, transacciones…)   │
                         └────────────────────────────────┘
