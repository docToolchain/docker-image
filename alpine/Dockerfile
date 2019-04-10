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
    libc6-compat \
    ttf-dejavu && \
    gem install rdoc --no-document && \
    gem install pygments.rb

# Add pandoc
# https://github.com/advancedtelematic/dockerfiles/blob/master/doctools/Dockerfile
#RUN apk add --no-cache cmark --repository http://nl.alpinelinux.org/alpine/edge/testing && \
#    apk add --no-cache --allow-untrusted pandoc --repository https://conoria.gitlab.io/alpine-pandoc/

SHELL ["/bin/bash", "-c"]

RUN echo "Install sdkman" &&\
    curl -s "https://get.sdkman.io" | bash && \
    chmod +x $HOME/.sdkman/bin/sdkman-init.sh && \
    $HOME/.sdkman/bin/sdkman-init.sh


RUN	echo "Install java, groovy" && \
    source $HOME/.sdkman/bin/sdkman-init.sh
#    sdk install groovy 2.5.5

RUN     git clone https://github.com/docToolchain/docToolchain.git && \
        cd docToolchain && \
        git checkout v1.1.0 && \
        git submodule update -i && \
        ./gradlew tasks && \
        ./gradlew && \
        PATH="/docToolchain/bin:${PATH}"

ENV PATH="/docToolchain/bin:${PATH}"

RUN mkdir /project

WORKDIR /project

VOLUME /project

ENTRYPOINT /bin/bash
