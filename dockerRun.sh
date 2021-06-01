#!/bin/bash
sudo docker rm public-homebridge -f || echo ""
sudo docker build -t public-homebridge .
sudo docker run -it public-homebridge