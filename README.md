# tragus/apache
tragus/ubuntu with apache2 installed & configured

## Building the image

```
git clone https://github.com/jcejohnson/docker-apache.git tragus-apache
cd tragus-apache
docker build -t tragus/apache .
```

## Running the container

Modify & use apache.launch to start the container. Use apache.shutdown to
cleanly shutdown the server or docker stop to terminate the instance more or
less immediately.

```
mknod /var/run/apache p
docker run -d -p 80:80 -v /var/run/apache:/var/run/container-control --name apache tragus/apache
```

The named pipe is used as a control mechanism for the container.
In this version, anything you send to the pipe will cause the container
to exit but we may do something more interesting in the future.
See the comments in apache2.start for more.

If you're running multiple such containers, you might want to bind
each to a different virtual IP:

```
ifconfig enp2s0:1 1.2.3.4
docker run -d -p 1.2.3.4.80:80 -v /var/run/apache:/var/run/container-control --name apache tragus/apache

ifconfig enp2s0:2 4.5.6.7
docker run -d -p 5.6.7.8.80:80 -v /var/run/apache:/var/run/container-control --name apache tragus/apache
```

You can also tweak the address:port of apache in the container. You would want
to do this, for instance, if you need to --net=host. Note that you do *not* need
to use this when using -p to bind to a virtual IP as described above.

```
ifconfig enp2s3:2 8.9.10.11
docker run -d --net=host -e apache_ipaddress=8.9.10.11 -e apache_http=8080 -e apache_https=8443 \
           -v /var/run/apache:/var/run/container-control --name apache tragus/apache
```

## Persistent Data

apache will care about these locations:

- /var/log/apache2
- /etc/apache2
- /var/www

You should map those to some out-of-container storage so that they persist across instances.

## TODO

Follow the pattern at https://github.com/cpuguy83/docker-nfs-server
to use runsvdir. Have inotifywait recursively monitor /etc/apache2
so that we can easily externalize and modify the apache configuration.

## Warning

There is no logfile management in the container at this time.
You may want to map /var/log/apache2 (or all of /var/log) to
host storage or a data-only container.

```
docker run -d -p 80:80 -v /var/run/apache:/var/run/container-control \
  -v /usr/local/log/apache2:/var/log/apache2 tragus/apache \
  --name apache tragus/apache
```

