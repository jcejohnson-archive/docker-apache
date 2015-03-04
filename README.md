# tragus/apache
tragus/ubuntu with apache2 installed & configured to run in the foreground.

## Building the image
```
git clone https://github.com/jcejohnson/docker-apache.git tragus-apache
cd tragus-apache
docker build -t tragus/apache .
```

## Running the container
```
docker run -d -p 80:80 --name apache tragus/apache
```

If you're running multiple such containers, you might want to bind
each to a different virtual IP:
```

ifconfig enp2s0:1 1.2.3.4
docker run -d -p 1.2.3.4:80:80 --name apacheFoo tragus/apache

ifconfig enp2s0:2 4.5.6.7
docker run -d -p 4.5.6.7:80:80 --name apacheBar tragus/apache
```

## TODO
Follow the pattern at https://github.com/cpuguy83/docker-nfs-server
to use runsvdir. Have inotifywait recursively monitor /etc/apache2
so that we can easily externalize and modify the apache configuration.

## Warning
There is no logfile management in the container at this time.
You may want to map /var/log/apache2 (or all of /var/log) to
host storage or a data-only container.
```
docker run -d -p 80:80 --name apache -v /usr/local/log/apache2:/var/log/apache2 tragus/apache
```
