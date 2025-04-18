# About
This container runs a remote instance of firefox with autofirma installed in a sandboxed environment. It can be accessed by any web browser (it runs as a VNC remote desktop).

# Motivation
Autofirma is required by many Spanish government websites for online operations, but its design raises several security concerns:
+ Has a messy and hard-to-audit code structure with over 100 classes.
+ Patches the client's web browser
+ Does not provide hashes for its built binaries
+ The built binary is downloaded from a website with a non-trusted HTTPS certificate controlled by the spanish government itself which has been known to enable sketchy MITM operations.
+ And many other concerns.

This setup allows running it on a centralized environment for third parties, if secured behind a private network and authenticated proxy.

# Requirements
+ docker https://docs.docker.com/engine/install/
+ docker-compose-plugin

# Usage
+ `./run.sh`
+ Access on any web browser @ `http://localhost:5800`
+ If you need any certificates inside the autofirma environment, copy them inside the `certificates/` folder. They'll be available inside the virtual environment in `/config/certificates/` (`Home/certificates` in the integrated file picker).