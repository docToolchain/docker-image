FROM eclipse-temurin:11-jdk-alpine

# see https://github.com/docker-library/openjdk/issues/73
ENV LC_CTYPE en_US.UTF-8

RUN addgroup -S dtcgroup && adduser -S dtcuser -G dtcgroup

RUN apk update && apk upgrade && apk add --no-cache build-base

RUN	echo "add needed tools" && \
    apk add --no-cache curl wget zip unzip git bash --virtual build-dependencies build-base\
    git \
    graphviz \
    python3 \
    ruby-dev \
    py-pygments \
    yaml-dev \
    ttf-dejavu
RUN gem update --system
RUN gem install rdoc --no-document
RUN gem install pygments.rb

WORKDIR /opt
RUN wget https://github.com/jgm/pandoc/releases/download/3.0.1/pandoc-3.0.1-linux-amd64.tar.gz -O /opt/pandoc.tar.gz
RUN tar -xzf /opt/pandoc.tar.gz -C /opt
RUN rm /opt/pandoc.tar.gz
ENV PATH=$PATH:/opt/pandoc-3.0.1/bin/

USER dtcuser
WORKDIR /home/dtcuser
ENV HOME=/home/dtcuser

ENV GRADLE_USER_HOME=/home/dtcuser/.gradle

ARG DTC_VERSION
RUN     git clone --branch ng https://github.com/docToolchain/docToolchain.git  && \
        cd docToolchain && \
        git fetch --tags && \
        git checkout ${DTC_VERSION} && \
        git submodule update -i && \
        # remove .git folders
        rm -rf `find -type d -name .git` && \
        umask g+w && \
        ./gradlew downloadDependencies && \
        chmod -R o=u $GRADLE_USER_HOME && \
        chmod -R g=u $GRADLE_USER_HOME && \
        rm -r $GRADLE_USER_HOME/daemon && \
        chmod -R o=u $HOME

# add reveal.js
RUN     cd /home/dtcuser/docToolchain/resources/. && \
        ./clone.sh && \
        cd -

ENV PATH="/home/dtcuser/docToolchain/bin:${PATH}"

USER dtcuser

WORKDIR /project

VOLUME /project

ENTRYPOINT /bin/bash
