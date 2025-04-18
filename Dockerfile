# FROM ubuntu:latest as base
FROM jlesage/firefox

######################################################################
# AutoFirma Debian package.

# FROM base as autofirma-deb

RUN apk add curl unzip
# RUN apt install -y ca-certificates wget unzip curl
# RUN curl https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma_Linux_Debian.zip --output /tmp/autofirma.zip
# RUN unzip /tmp/autofirma.zip AutoFirma_*.deb -d /tmp

######################################################################
# Firefox

# FROM jlesage/firefox

# Install AutoFirma.
RUN apk add dpkg nss openjdk17
# COPY --from=autofirma-deb /tmp/AutoFirma_*.deb /tmp/
# Install deb even though we're on Alpine linux!
# RUN dpkg -i /tmp/AutoFirma_*.deb

VOLUME /config/certificates
