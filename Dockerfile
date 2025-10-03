# 1. Utiliser une image Linux de base (Debian ou Ubuntu)
FROM debian:bookworm

# 2. Mettre à jour les dépôts et installer Apache (version souhaitée)
# Remarque : l’option -y permet d’éviter les confirmations interactives
RUN apt-get update && \
    apt-get install -y apache2 apache2-utils

# 3. Installer PHP et ses extensions
# Exemple avec PHP 8.2 — on peut changer la version ici (php7.4, php8.3, etc.)
RUN apt-get install -y php8.2 \
                       libapache2-mod-php8.2 \
                       php8.2-mysql \
                       php8.2-cli \
                       php8.2-curl \
                       php8.2-xml \
                       php8.2-mbstring

# 4. Activer le module PHP pour Apache
RUN a2enmod php8.2

# 5. Copier le code source de l’application dans le dossier web d’Apache
COPY ./src /var/www/html

# 6. Définir les permissions pour éviter les problèmes d’accès
RUN chown -R www-data:www-data /var/www/html

# 7. Exposer le port HTTP d’Apache
EXPOSE 80

# 8. Lancer Apache en mode premier plan (indispensable pour les conteneurs)
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
