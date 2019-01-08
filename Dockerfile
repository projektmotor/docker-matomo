FROM matomo:apache

RUN a2enmod rewrite headers ssl && \
    openssl genrsa -passout pass:x -out /etc/ssl/private/matomo.pass.key 2048 && \
    openssl rsa -passin pass:x -in /etc/ssl/private/matomo.pass.key -out /etc/ssl/private/matomo.key && \
    openssl req -new -key /etc/ssl/private/matomo.key -out /etc/ssl/private/matomo.csr -batch && \
    openssl x509 -req -days 365 -in /etc/ssl/private/matomo.csr -signkey /etc/ssl/private/matomo.key -out /etc/ssl/private/matomo.crt

COPY ./apache/* /etc/apache2/sites-available/
