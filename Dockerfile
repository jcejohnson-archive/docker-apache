FROM tragus/ubuntu

MAINTAINER James Johnson

RUN apt-get update && \
    apt-get -y install apache2

# We need a place to put our scripts
RUN mkdir -p /usr/local/bin

# Perform build-time configuration of the container
ADD apache2.configure /usr/local/bin/apache2.configure
RUN chmod +x /usr/local/bin/apache2.* && /usr/local/bin/apache2.configure

# Install any other scripts
ADD apache2.start /usr/local/bin/apache2.start

ENTRYPOINT ["/usr/local/bin/apache2.start"]
