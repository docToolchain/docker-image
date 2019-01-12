FROM ubuntu:18.10

MAINTAINER Ralf D. Mueller <ralf.d.mueller@docs-as-co.de>

LABEL version="0.1"
LABEL description="docToolchain in a box"
LABEL vendor="docToolChain"

ENV SDKMAN_DIR=/root/.sdkman
ENV SHELL /bin/bash
ENV DT_HOME=/home/docToolchain

RUN	echo "add needed tools" && \
    apt-get update && \
    apt-get -y install curl wget zip unzip git openjdk-8-jdk && \
    rm /bin/sh && ln -s /bin/bash /bin/sh

RUN echo "Install sdkman" && \
    curl -s "https://get.sdkman.io" | bash && \
    echo "$HOME" && \
    bash -c "chmod +x $HOME/.sdkman/bin/sdkman-init.sh" && \
    $HOME/.sdkman/bin/sdkman-init.sh && \
    echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config && \
    echo "Install java, groovy" && \
    source $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk install groovy 2.5.5

RUN mkdir $DT_HOME && cd $DT_HOME && \
    git clone https://github.com/docToolchain/docToolchain.git && \
    cd docToolchain && \
    git submodule update -i && \
    ./gradlew tasks

ENTRYPOINT bash
