FROM debian:latest
MAINTAINER Damien Lagae <damien@lagae.info>

# Set the enviroment variable
ENV DEBIAN_FRONTEND noninteractive

# Install required packages
RUN apt-get clean all
RUN apt-get update 
RUN apt-get -y install supervisor 
RUN apt-get -y install mysql-server 
RUN apt-get -y install apache2 
RUN apt-get -y install php5 libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc php5-curl curl lynx-cur
RUN apt-get -y install git

# Add shell scripts for starting apache2
ADD shell/apache2-start.sh /apache2-start.sh

# Add shell scripts for starting mysql
ADD shell/mysql-start.sh /mysql-start.sh
ADD shell/run.sh /run.sh

# Add MySQL utils
ADD shell/mysql_user.sh /mysql_user.sh

# Give the execution permissions
RUN chmod 755 /*.sh

# Add the Configurations files
ADD conf/my.cnf /etc/mysql/conf.d/my.cnf
ADD conf/supervisord-lamp.conf /etc/supervisor/conf.d/supervisord-lamp.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Enviroment variable for setting the Username and Password of MySQL
ENV MYSQL_USER root
ENV MYSQL_PASS toor

# Enable apache mods.
RUN a2enmod php5
RUN a2enmod rewrite

# Add volumes for MySQL & Apache
VOLUME  ["/etc/mysql", "/var/lib/mysql" , "/var/www/"]
