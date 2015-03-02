FROM tragus/ubuntu

MAINTAINER James Johnson

RUN apt-get update && \
    apt-get -y install apache2 && \
    echo "export APACHE_ARGUMENTS='-DFOREGROUND'" >> /etc/apache2/envvars

EXPOSE 80

ENTRYPOINT /etc/init.d/apache2 start
