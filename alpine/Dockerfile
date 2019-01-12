FROM openjdk:8u191-jdk-alpine

ENV SDKMAN_DIR=/root/.sdkman

RUN	echo "add needed tools" && \
    apk add --no-cache curl wget zip unzip git bash \
    git graphviz

SHELL ["/bin/bash", "-c"]
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

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
        ./gradlew tasks

ENV PATH="/docToolchain/bin:${PATH}"

RUN mkdir /home/project

WORKDIR $DT_HOME/docToolchain

VOLUME /home/project

ENTRYPOINT bash
