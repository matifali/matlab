# matlab

A custom matlab docker image for my own use.

This image has been built on top of the [matlab](https://hub.docker.com/r/mathworks/matlab/) image from MathWorks.

Published to `ghcr.io/matifali/matlab` with tags `latest` and `r2026a`.

```bash
docker pull ghcr.io/matifali/matlab:latest
```

## Build

Builds on `mathworks/matlab:r2026a` by default. Override with `MATLAB_RELEASE`:

```bash
docker build -t matlab .
docker build --build-arg MATLAB_RELEASE=r2025b -t matlab:r2025b .
```

## Run MATLAB in desktop mode and interact with it via VNC

To start the MATLAB desktop, execute:

```bash
docker run -it --rm -p 5901:5901 -p 6080:6080 --shm-size=512M ghcr.io/matifali/matlab:latest -vnc
```

To connect to the MATLAB desktop, either:

1. Point a browser to port 6080 of the docker host machine running this container e.g [http://localhost:6080](http://localhost:6080) for the local machine.
2. Use a VNC client to connect to display 1 of the docker host machine (hostname:1)
The VNC password is matlab by default. Use the `PASSWORD` environment variable to change it.

## Run MATLAB and interact with it via a web browser

To start the container, execute:

```bash
docker run -it --rm -p 8888:8888 --shm-size=512M ghcr.io/matifali/matlab:latest -browser
```

Running the above command prints text to your terminal containing the URL to access MATLAB. For example:

MATLAB can be accessed at:
[http://localhost:8888/index.html](http://localhost:8888/index.html)

## List of toolboxes

See [`products.txt`](products.txt). It lists all R2026a products; uncommented ones are installed in this image. Uncomment a line to add a toolbox.
