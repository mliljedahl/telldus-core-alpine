#!/bin/sh
# Based on https://github.com/stoffus/docker-telldus
# With insperation from https://github.com/home-assistant/hassio-addons/tree/master/tellstick

set -e

if [ -e /tmp/TelldusClient ]; then
    rm /tmp/TelldusClient
fi

if [ -e /tmp/TelldusEvents ]; then
    rm /tmp/TelldusEvents
fi

if [ ! -f /etc/telldus.conf ]; then
    echo "Configuration file '/etc/telldus.conf' is missing, please refer"
    echo "to the documentation on how to mount the configuration file."
    echo ""
    echo "https://github.com/mliljedahl/telldus-core-alpine/README.md"
    exit 1
fi

# Expose the unix socket to internal network
socat TCP-LISTEN:50800,reuseaddr,fork UNIX-CONNECT:/tmp/TelldusClient &
socat TCP-LISTEN:50801,reuseaddr,fork UNIX-CONNECT:/tmp/TelldusEvents &

# Run telldus-core daemon in the background
/usr/local/sbin/telldusd --nodaemon

