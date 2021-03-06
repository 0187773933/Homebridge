FROM debian:stable-slim
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get install apt-transport-https -y
RUN apt-get install apt-utils -y
RUN apt-get install gcc -y
RUN apt-get install g++ -y
RUN apt-get install nano -y
RUN apt-get install tar -y
RUN apt-get install bash -y
RUN apt-get install sudo -y
RUN apt-get install openssl -y
RUN apt-get install git -y
RUN apt-get install make -y
RUN apt-get install wget -y
RUN apt-get install curl -y
# RUN apt-get install openssh-server -y
# RUN apt-get install openssh-client -y
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y
RUN apt-get install python3-dev -y
RUN apt-get install python3-setuptools -y
RUN apt-get install python -y
RUN apt-get install net-tools -y
RUN apt-get install iproute2 -y
RUN apt-get install iputils-ping -y

# https://github.com/oznu/docker-s6-alpine-node/blob/master/Dockerfile.ubuntu
RUN apt-get install locales -y
RUN apt-get install psmisc -y
RUN apt-get install procps -y
RUN apt-get install logrotate -y
RUN apt-get install libatomic1 -y
# https://github.com/oznu/docker-homebridge/blob/master/Dockerfile.ubuntu
RUN apt-get install ffmpeg -y
RUN apt-get install libnss-mdns -y
RUN apt-get install avahi-discover -y
RUN apt-get install libavahi-compat-libdnssd-dev -y

ARG USERNAME="morphs"
ARG PASSWORD="asdf"
RUN useradd -m $USERNAME -p $PASSWORD -s "/bin/bash"
RUN mkdir -p /home/$USERNAME
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME
RUN usermod -aG sudo $USERNAME
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME

# https://stackoverflow.com/questions/25899912/how-to-install-nvm-in-docker
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN mkdir -p /home/$USERNAME/.nvm
ENV NVM_DIR /home/$USERNAME/.nvm
ARG NVM_VERSION="0.38.0"
ARG NODE_VERSION="14.17.0"
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash
RUN chmod +x $HOME/.nvm/nvm.sh
RUN . $HOME/.nvm/nvm.sh && nvm install v$NODE_VERSION

USER root
RUN ln -sf /home/$USERNAME/.nvm/versions/node/v$NODE_VERSION/bin/node /usr/bin/nodejs
RUN ln -sf /home/$USERNAME/.nvm/versions/node/v$NODE_VERSION/bin/node /usr/bin/node
RUN ln -sf /home/$USERNAME/.nvm/versions/node/v$NODE_VERSION/bin/npm /usr/bin/npm
USER $USERNAME

RUN mkdir -p /home/$USERNAME/homebridge
WORKDIR /home/$USERNAME/homebridge
# RUN npm install -g --unsafe-perm homebridge
RUN npm install -g --unsafe-perm homebridge@1.3.4-beta.4
RUN npm install -g --unsafe-perm homebridge-config-ui-x

RUN /usr/bin/python3 -m pip install tzupdate
RUN npm set prefix /usr/bin
RUN npm config set unsafe-perm true

RUN mkdir -p /home/$USERNAME/.homebridge
COPY ./config /home/$USERNAME/.homebridge
RUN sudo chown -R morphs:morphs /home/$USERNAME/.homebridge
#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT [ "/home/morphs/.nvm/versions/node/v14.17.0/bin/homebridge" ]