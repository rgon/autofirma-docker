FROM debian:bookworm-slim AS autofirma_dl

RUN apt-get update && apt-get -y install curl unzip
RUN curl https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma19/Autofirma_Linux_Debian.zip --output /tmp/autofirma.zip
RUN unzip /tmp/autofirma.zip autofirma_*.deb -d /tmp

FROM linuxserver/firefox:latest

# Install AutoFirma.
RUN apt-get update && apt-get -y install openjdk-11-jdk libnss3-tools

# Copy AutoFirma from the previous stage.
COPY --from=autofirma_dl /tmp/autofirma_*.deb /tmp/
# Install deb even though we're on Alpine linux!
RUN dpkg -i /tmp/autofirma_*.deb

# Fix ugly java font rendering
RUN echo "export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'" >> /etc/profile.d/jre.sh
RUN echo "export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'" >> .bashrc

# Autofirma configuration
COPY ./scripts/configure_autofirma.sh /usr/local/bin/configure_autofirma.sh
RUN /usr/local/bin/configure_autofirma.sh

VOLUME /config/certificates
