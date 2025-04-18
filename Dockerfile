FROM debian:bookworm-slim AS autofirma_dl

RUN apt-get update && apt-get -y install curl unzip
RUN curl https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma_Linux_Debian.zip --output /tmp/autofirma.zip
RUN unzip /tmp/autofirma.zip AutoFirma_*.deb -d /tmp

FROM linuxserver/firefox:latest

# Install AutoFirma.
RUN apt-get update && apt-get -y install openjdk-21-jdk libnss3-tools

# Copy AutoFirma from the previous stage.
COPY --from=autofirma_dl /tmp/AutoFirma_*.deb /tmp/
# Install deb even though we're on Alpine linux!
RUN dpkg -i /tmp/AutoFirma_*.deb

# Fix ugly java font rendering
RUN echo "export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'" >> /etc/profile.d/jre.sh
RUN echo "export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'" >> .bashrc

VOLUME /config/certificates
