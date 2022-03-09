FROM openjdk:13-jdk-alpine

# see https://github.com/docker-library/openjdk/issues/73
ENV LC_CTYPE en_US.UTF-8

RUN addgroup -S dtcgroup && adduser -S dtcuser -G dtcgroup

RUN apk update && apk add --no-cache build-base

RUN	echo "add needed tools" && \
    apk add --no-cache curl wget zip unzip git bash \
    git \
    graphviz \
    python \
    ruby \
    ruby-dev \
    py-pygments \
    libc6-compat \
    ttf-dejavu 
RUN gem install --no-ri --no-rdoc  rdoc --no-document 
#RUN gem install --no-ri --no-rdoc pygments.rb
RUN apk del ruby-dev

# Add pandoc
# https://github.com/advancedtelematic/dockerfiles/blob/master/doctools/Dockerfile
#RUN apk add --no-cache cmark --repository http://nl.alpinelinux.org/alpine/edge/testing && \
#    apk add --no-cache --allow-untrusted pandoc --repository https://conoria.gitlab.io/alpine-pandoc/

SHELL ["/bin/bash", "-c"]

USER dtcuser
WORKDIR /home/dtcuser
ENV HOME=/home/dtcuser

ENV GRADLE_USER_HOME=/home/dtcuser/.gradle

RUN     git clone --branch ng https://github.com/docToolchain/docToolchain.git  && \
        cd docToolchain && \
        git fetch --tags && \
        git checkout v2.0.4 && \
        git submodule update -i && \
        # remove .git folders
        rm -rf `find -type d -name .git` && \
        umask g+w && \
        ./gradlew tasks && \
        ./gradlew dependencies && \
        chmod -R o=u $GRADLE_USER_HOME && \
        chmod -R g=u $GRADLE_USER_HOME && \
        rm -r $GRADLE_USER_HOME/daemon && \
        chmod -R o=u $HOME

ENV PATH="/home/dtcuser/docToolchain/bin:${PATH}"

USER dtcuser

WORKDIR /project

VOLUME /project

ENTRYPOINT /bin/bash
