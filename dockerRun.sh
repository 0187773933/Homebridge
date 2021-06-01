#!/bin/bash
# sudo docker rm public-homebridge -f || echo ""
sudo docker build -t public-homebridge .
#sudo docker run -it public-homebridge
sudo docker run -it \
--net=host \
public-homebridge

# --mount type=bind,source="$(pwd)"/config,target=/home/morphs/.homebridge \
# sudo docker run -dit --restart='always' \
# --name public-homebridge \
# --net=host \
# --mount type=bind,source="$(pwd)"/config,target=/home/morphs/.homebridge \
# public-homebridge

# --privileged
# -p 8581:8581 \