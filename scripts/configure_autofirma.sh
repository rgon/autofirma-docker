#!/bin/bash

# This script configures the environment so that AutoFirma events triggered from the web browser open correctly.


configure_xdg_mime() {
    <<EOF install -m644 /dev/stdin /usr/share/applications/mimeapps.list
[Default Applications]
x-scheme-handler/afirma=afirma.desktop
EOF
}

configure_xdg_mime