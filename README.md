# Proyecto Laravel 12 con Docker

Este proyecto está preparado para **Laravel 12** usando **PHP 8.4**, **MariaDB 11**, **Nginx** y **phpMyAdmin**, con soporte completo para desarrollo y producción. Incluye configuración moderna de testing con **Pest** en lugar de PHPUnit.

---

## 🗂 Estructura del proyecto

```
.
├── app/                 # Código Laravel
├── bootstrap/
├── config/
├── database/
├── docker/
│   ├── php/             # Dockerfile PHP
│   └── nginx/           # Configuración Nginx
├── public/
├── resources/
├── routes/
├── storage/
├── tests/               # Contiene tests con Pest
├── composer.json
├── composer.lock
└── docker-compose.yml
```

---

## ⚙ Requisitos

* Docker ≥ 20.x
* Docker Compose ≥ 2.x
* Mac / Linux / Windows con soporte Docker
* Laravel 12
* PHP 8.4 (configurado en Dockerfile)
* Composer 2.x
* Pest para testing

---

## 🚀 Levantar el entorno

1. **Detener contenedores antiguos** (si existen):

```bash
docker-compose down
docker-compose rm -f
```

2. **Construir y levantar contenedores:**

```bash
docker-compose build --no-cache app
docker-compose up -d
```

3. **Verificar PHP:**

```bash
docker-compose exec app php -v
```

Deberías ver **PHP 8.4.x**.

4. **Acceder a phpMyAdmin:**

* URL: [http://localhost:8080](http://localhost:8080)
* Usuario: `laravel`
* Password: `secret`
* Host: `mariadb`

5. **Verificar Nginx:**

* URL: [http://localhost:8000](http://localhost:8000)

---

## 💾 Composer y dependencias

* Las dependencias de PHP ya se instalan durante el build del contenedor:

```bash
composer install --no-dev --optimize-autoloader
```

* Para instalar nuevas dependencias:

```bash
docker-compose exec app composer require vendor/package
```

* En desarrollo, puedes regenerar autoload:

```bash
docker-compose exec app composer dump-autoload
```

* Pest ya está instalado como framework de testing. Para ejecutar tests:

```bash
docker-compose exec app ./vendor/bin/pest
```

---

## 🔧 Laravel Commands

Dentro del contenedor `app`:

* Migraciones:

```bash
docker-compose exec app php artisan migrate --force
```

* Crear usuario:

```bash
docker-compose exec app php artisan tinker
```

* Cache y configuración:

```bash
docker-compose exec app php artisan config:cache
docker-compose exec app php artisan route:cache
```

* Ejecutar tests con Pest:

```bash
docker-compose exec app ./vendor/bin/pest
```

---

## 🔹 Settings del contenedor

| Servicio       | Puerto | Usuario/Password |
| -------------- | ------ | ---------------- |
| **Nginx**      | 8000   | -                |
| **MariaDB**    | 3307   | laravel / secret |
| **phpMyAdmin** | 8080   | laravel / secret |
| **PHP-FPM**    | 9000   | -                |

* Volumen `mariadb_data` asegura persistencia de la base de datos
* El código de Laravel se monta como volumen para desarrollo
* Permisos de `storage` y `bootstrap/cache` ya ajustados

---

## ⚡ Tips

* Siempre reconstruir `app` si cambias versión de PHP:

```bash
docker-compose build --no-cache app
```

* Para producción: usa `composer install --no-dev --optimize-autoloader`
* Para desarrollo: mantener el volumen montado para que los cambios se reflejen en tiempo real
* Para limpiar todo y reiniciar:

```bash
docker-compose down -v --remove-orphans
```

* Pest se recomienda para tests en lugar de PHPUnit. Puedes crear tests nuevos con:

```bash
docker-compose exec app php artisan pest:test NombreTest
```

---

## 📝 Resumen del flujo

1. Clonar proyecto
2. Ajustar `.env` de Laravel
3. Levantar contenedores con `docker-compose up -d`
4. Ejecutar migraciones y comandos Laravel
5. Ejecutar tests con Pest: `./vendor/bin/pest`
6. Acceder a la app por `http://localhost:8000` y phpMyAdmin por `http://localhost:8080`

---

**¡Listo! Entorno Laravel 12 con PHP 8.4 y Pest completamente funcional.**
