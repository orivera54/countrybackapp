FROM php:8.2-fpm

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev libonig-dev libxml2-dev zip unzip git curl libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

# Instala Composer desde la imagen oficial
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia archivos del proyecto
COPY . .

# Instala dependencias PHP
RUN composer install --no-dev --optimize-autoloader

# Variables de entorno para Laravel (Render también puede configurarlas en el dashboard)
ENV DB_CONNECTION=pgsql
ENV DATABASE_URL="postgresql://neondb_owner:npg_j84tViNZLzcs@ep-damp-sunset-aecai72u-pooler.c-2.us-east-2.aws.neon.tech/cities_app?sslmode=require&channel_binding=require&options=endpoint%3Dep-damp-sunset-aecai72u"

# Puerto que Render espera por defecto
EXPOSE 8080

# Comando para servir Laravel directamente
CMD php artisan serve --host=0.0.0.0 --port=8080