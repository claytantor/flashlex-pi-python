#!/bin/bash
# stop script on error
set -e

THING_NAME=$1
THING_ENDPOINT=$2

python3 -m venv venv --system-site-packages

if [ $(python3 openssl.py) == "true" ]
then

echo OpenSSL is enabled.

# install pip3 to virtualenv
curl https://bootstrap.pypa.io/get-pip.py | ./venv/bin/python

# install the requirements
./venv/bin/pip install -r requirements.txt

# tell the user
echo "thing name: ${THING_NAME} thing endpoint: ${THING_ENDPOINT}"

# run the pubsub
./venv/bin/python -u bootstrap.py -c keys/config-bootstrap.yml -d $(pwd)/data -k $(pwd)/../. 

else
echo ERROR: OpenSSL is required fro IOT TLS.
exit 0
fi
