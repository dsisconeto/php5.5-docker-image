FROM ubuntu:14.04
MAINTAINER Dejair Sisconeto <dejairssiconeto23@gmail.com>

VOLUME ["/var/www"]

RUN apt-get update -y && \
    apt-get install -y \ 
    apache2 \ 
    php5 \ 
    php5-cli \ 
    libapache2-mod-php5 \ 
    php5-gd \
    php5-json \ 
    php5-ldap \
    php5-mysql \
    php5-pgsql \
    php5-dev \
    php5-cli \
    php-pear \
    libssl-dev \ 
    re2c \
    pkg-config \
    libsasl2-dev \
    libpcre3-dev \
    php5-mongo 

RUN pecl install mongo

RUN sh -c "echo 'extension=mongo.so' > /etc/php5/mods-available/mongo.ini"
RUN ln -s /etc/php5/mods-available/mongo.ini /etc/php5/apache2/conf.d/mongo.ini

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY php.ini  /etc/php5/apache2/php.ini
COPY php.ini  /etc/php5/cli/php.ini
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80

CMD ["/usr/local/bin/run"]
