# Hackaton Backend

Este es el backend del proyecto Hackaton, desarrollado en Node.js con Express y conectado a una base de datos MySQL.

## Endpoints principales

- `GET /api/ping` — Verifica que el backend está funcionando.
- `GET /api/validar-db` — Valida la conexión con la base de datos MySQL.
- `GET /api/ejemplo` — Muestra las tablas existentes en la base de datos.
- `GET /api/productos/atributos` — Devuelve los atributos (columnas) de la tabla `productos`.
- `GET /api/productos` — Devuelve el listado de productos.

## Variables de entorno

Estas variables se configuran automáticamente desde `docker-compose.yml`:

- `DB_HOST` (por defecto: `db`)
- `DB_USER` (por defecto: `hackaton`)
- `DB_PASSWORD` (por defecto: `hackaton`)
- `DB_NAME` (por defecto: `hackaton`)

## Uso con Docker

1. Asegúrate de tener Docker y Docker Compose instalados.
2. Desde la raíz del proyecto, ejecuta:
   ```bash
   docker-compose up --build
   ```
3. El backend estará disponible en `http://localhost:5000`.

## Estructura de carpetas

```
backend/
  ├── Dockerfile
  ├── package.json
  └── src/
      └── index.js
```

## Notas
- El backend se conecta a la base de datos MySQL definida en el servicio `db` de Docker Compose.
- El archivo SQL de inicialización debe contener la tabla `productos` y los datos necesarios.
- Puedes modificar o agregar endpoints en `src/index.js`.
