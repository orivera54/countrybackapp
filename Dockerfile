FROM php:8.2-fpm

# Instala dependencias del sistema y extensiones PHP necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev libonig-dev libxml2-dev zip unzip git curl libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

# Instala Composer desde la imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define el directorio de trabajo dentro del contenedor
WORKDIR /var/www/html

# Copia todo tu proyecto Laravel al contenedor
COPY . .

# Instala las dependencias de Laravel
RUN composer install --ignore-platform-reqs --no-interaction --prefer-dist

# Expone el puerto HTTP que Render espera
EXPOSE 8080

# Chequeo de salud
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl --fail http://localhost:8080/api/health || exit 1

# Comando para ejecutar migraciones y servir Laravel vía Artisan
CMD php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=8080