#!/bin/bash
#
# Do not configure this file.
#

source utils.sh

IP=$1
PASS=$2

echo -e "$LIGHTGREEN=== START DEPLOY ===$NC\n"

cd install_sh

sshpass -p $PASS rsync -avP bin resources translations rock@$IP:/testImageGraph/
sshpass -p $PASS ssh rock@$IP 'chmod +x /testImageGraph/bin/testImageGraph'

cd ../

echo -e "$LIGHTGREEN=== END DEPLOY ===$NC\n"