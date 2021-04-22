FROM openjdk:13-jdk-alpine

# see https://github.com/docker-library/openjdk/issues/73
ENV LC_CTYPE en_US.UTF-8

RUN addgroup -S dtcgroup && adduser -S dtcuser -G dtcgroup


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

USER dtcuser
WORKDIR /home/dtcuser
ENV HOME=/home/dtcuser

RUN echo "Install sdkman" &&\
    curl -s "https://get.sdkman.io" | bash && \
    chmod +x $HOME/.sdkman/bin/sdkman-init.sh && \
    $HOME/.sdkman/bin/sdkman-init.sh


RUN	echo "Install java, groovy" && \
    source $HOME/.sdkman/bin/sdkman-init.sh
#    sdk install groovy 2.5.5

ENV GRADLE_USER_HOME=/home/dtcuser/.gradle

RUN     git clone --depth 1 --branch ng https://github.com/docToolchain/docToolchain.git  && \
        cd docToolchain && \
        git fetch --tags && \
        git checkout v2.0.0-rc13 && \
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
