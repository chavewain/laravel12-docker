#!/bin/bash
set -e

# 1. Crear el .env si no existe
if [ ! -f /var/www/.env ]; then
    echo "Creando .env desde .env.example..."
    cp /var/www/.env.example /var/www/.env
fi

# 2. Instalar dependencias de Composer si no existen
if [ ! -d /var/www/vendor ]; then
    echo "Instalando dependencias PHP con Composer..."
    composer install --no-dev --optimize-autoloader --prefer-dist
fi

# 3. Ajustar permisos de Laravel
echo "Ajustando permisos..."
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# 4. Ejecutar el comando pasado al contenedor (php-fpm, artisan, etc.)
exec "$@"
