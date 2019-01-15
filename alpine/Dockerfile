FROM openjdk:8u191-jdk-alpine

ENV SDKMAN_DIR=/root/.sdkman

# see https://github.com/docker-library/openjdk/issues/73
ENV LC_CTYPE en_US.UTF-8

RUN	echo "add needed tools" && \
    apk add --no-cache curl wget zip unzip git bash \
    git \
    graphviz \
    python \
    ruby \
    py-pygments \
    ttf-dejavu && \
    gem install rdoc --no-document && \
    gem install pygments.rb

SHELL ["/bin/bash", "-c"]

RUN echo "Install sdkman" &&\
    curl -s "https://get.sdkman.io" | bash

RUN echo "$HOME"
RUN chmod +x $HOME/.sdkman/bin/sdkman-init.sh
RUN $HOME/.sdkman/bin/sdkman-init.sh


RUN	echo "Install java, groovy" && \
    source $HOME/.sdkman/bin/sdkman-init.sh
#    sdk install groovy 2.5.5

RUN     git clone https://github.com/docToolchain/docToolchain.git && \
        cd docToolchain && \
        git submodule update -i && \
        ./gradlew tasks && \
        ./gradlew && \
        PATH="/docToolchain/bin:${PATH}"

ENV PATH="/docToolchain/bin:${PATH}"

RUN mkdir /home/project

WORKDIR $DT_HOME/docToolchain

VOLUME /home/project

CMD bash
ENTRYPOINT bash
