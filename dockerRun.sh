#!/bin/bash
# sudo docker rm public-homebridge -f || echo ""
# sudo docker build -t public-homebridge .
# sudo docker run -it \
# --net=host \
# public-homebridge

id=$(sudo docker run -dit --restart='always' \
--name public-homebridge \
--net=host \
public-homebridge)
echo $id
sudo docker logs -f $id