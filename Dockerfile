# Usiamo l'immagine ufficiale di PHP 7.4 (richiesta da Chamilo 1.11.x)
FROM php:7.4-apache

# Installiamo le dipendenze di sistema e le estensioni PHP necessarie
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql zip intl opcache bcmath soap \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installiamo Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurazione ottimizzata di PHP
RUN { \
        echo 'max_execution_time = 300'; \
        echo 'memory_limit = 512M'; \
        echo 'upload_max_filesize = 100M'; \
        echo 'post_max_size = 100M'; \
        echo 'date.timezone = Europe/Rome'; \
        echo 'display_errors = On'; \
    } > /usr/local/etc/php/conf.d/chamilo-optimizations.ini

# Abilitiamo il modulo rewrite di Apache
RUN a2enmod rewrite

# Cloniamo il branch STABILE (1.11.x) di Chamilo
RUN rm -rf /var/www/html/* \
    && git clone -b 1.11.x --depth=1 https://github.com/chamilo/chamilo-lms.git /var/www/html/

# Autorizziamo Composer a girare come root e diciamo a Git che la cartella è sicura
ENV COMPOSER_ALLOW_SUPERUSER=1
WORKDIR /var/www/html/
RUN git config --global --add safe.directory /var/www/html \
    && composer install --no-dev --optimize-autoloader

# Configuriamo i permessi corretti per l'utente web
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/

# Copia il file di configurazione pre-compilato
COPY configuration.php /var/www/html/app/config/configuration.php

# Applica le regole di sicurezza richieste da Chamilo
RUN chmod 0755 /var/www/html/app/config && \
    rm -rf /var/www/html/main/install/

# Esponiamo la porta 80
EXPOSE 80