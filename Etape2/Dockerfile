# Utiliser l'image PHP-FPM comme base
FROM php:8.1-fpm

# Installer les extensions nécessaires
RUN docker-php-ext-install mysqli

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier test_bdd.php dans le répertoire de travail
COPY test_bdd.php .

# Donner les permissions à www-data
RUN chown -R www-data:www-data /app
