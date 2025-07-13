# Etapa de construcción
FROM composer:2 as builder

WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-interaction --optimize-autoloader

COPY . .

# Etapa de producción
FROM php:8.2-fpm-alpine

# Instalar dependencias necesarias
RUN apk add --no-cache \
    nginx \
    supervisor \
    postgresql-dev \
    libzip-dev \
    && docker-php-ext-install \
    pdo \
    pdo_pgsql \
    zip \
    opcache

# Configurar Nginx
#COPY docker/nginx.conf /etc/nginx/nginx.conf

# Configurar PHP
#COPY docker/php.ini /usr/local/etc/php/conf.d/opcache.ini

# Configurar supervisor
#COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copiar la aplicación Laravel
WORKDIR /var/www/html
COPY --from=builder /app .
#COPY .env.production .env

# Configurar conexión a PostgreSQL (se sobrescribirá con variables de entorno en Render)
#RUN sed -i "s|DB_CONNECTION=.*|DB_CONNECTION=pgsql|" .env && \
#    sed -i "s|DB_HOST=.*|DB_HOST=ep-restless-sunset-a8txfsrn-pooler.eastus2.azure.neon.tech|" .env && \
#    sed -i "s|DB_PORT=.*|DB_PORT=5432|" .env && \
#    sed -i "s|DB_DATABASE=.*|DB_DATABASE=neondb|" .env && \
#    sed -i "s|DB_USERNAME=.*|DB_USERNAME=neondb_owner|" .env && \
#    sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=npg_YQVJXAM0KRr4|" .env && \
#    sed -i "s|APP_ENV=.*|APP_ENV=production|" .env && \
#    sed -i "s|APP_DEBUG=.*|APP_DEBUG=false|" .env

# Configurar permisos
#RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Limpiar caché de configuración
RUN php artisan config:clear

# Puerto expuesto (Render usará este puerto)
EXPOSE 8080

# Comando de inicio
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]