# tragus/apache
tragus/ubuntu with apache2 installed & configured

## Building the image

```
git clone https://github.com/jcejohnson/docker-apache.git tragus-apache
cd tragus-apache
docker build -t tragus/apache .
```

## Running the container

Modify & use apache.launch to start the container.

```
docker run -d -t -p 80:80 \
    -e apache_http="80" \
    -e apache_https="443" \
    -e apache_ipaddress="0.0.0.0" \
    -v /usr/local/var/www:/var/www \
    --name apache tragus/apache
```

If you're running multiple such containers, you might want to bind
each to a different virtual IP:

```
ifconfig enp2s0:1 1.2.3.4
docker run -d -p 1.2.3.4.80:80 --name apache tragus/apache

ifconfig enp2s0:2 4.5.6.7
docker run -d -p 5.6.7.8.80:80 --name apache tragus/apache
```

You can also tweak the address:port of apache in the container. You would want
to do this, for instance, if you need to --net=host. Note that you do *not* need
to use this when using -p to bind to a virtual IP as described above.

```
ifconfig enp2s3:2 8.9.10.11
docker run -d --net=host \
    -e apache_http=8080 \
    -e apache_https=8443 \
    -e apache_ipaddress=8.9.10.11 \
    --name apache tragus/apache
```

## Persistent Data

apache will care about these locations:

- /var/log/apache2
- /etc/apache2
- /var/www

You should map those to some out-of-container storage so that they persist across instances.

## Warning

There is no logfile management in the container at this time.
You may want to map /var/log/apache2 (or all of /var/log) to
host storage or a data-only container.

```
docker run -d -p 80:80 \
  -v /usr/local/log/apache2:/var/log/apache2 \
  --name apache tragus/apache
```

