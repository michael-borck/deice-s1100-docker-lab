#!/bin/bash

# Start all services
service apache2 start
service ssh start
service vsftpd start
service postfix start
service dovecot start

# Keep container running
tail -f /dev/null