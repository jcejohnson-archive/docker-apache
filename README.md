# jcejohnson/apache
jcejohnson/ubuntu with apache2 installed & configured to run in the foreground.

## Building the image
```
git clone https://github.com/jcejohnson/docker-apache.git jcejohnson-apache
cd jcejohnson-apache
docker build -t jcejohnson/apache .
```

## Running the container
```
docker run -i -t -p 80:80 --name apache jcejohnson/apache

If you're running multiple such containers, you might want to bind
each to a different virtual IP:

ifconfig enp2s0:1 1.2.3.4
docker run -i -t -p 1.2.3.4:80:80 --name apacheFoo jcejohnson/apache

ifconfig enp2s0:2 4.5.6.7
docker run -i -t -p 4.5.6.7:80:80 --name apacheBar jcejohnson/apache
```

