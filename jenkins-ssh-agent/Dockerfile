FROM jenkins/ssh-agent:alpine-jdk11

USER root

# see https://github.com/docker-library/openjdk/issues/73
ENV LC_CTYPE en_US.UTF-8

#RUN addgroup -S dtcgroup && adduser -S dtcuser -G dtcgroup

RUN apk update && apk add --no-cache build-base

RUN	echo "add needed tools" && \
    apk add --no-cache curl wget zip unzip git bash --virtual build-dependencies build-base\
    git \
    graphviz \
    python3 \
    ruby-dev \
    py-pygments \
    libc6-compat \
    ttf-dejavu 
RUN gem update --system
RUN gem install rdoc --no-document 
RUN gem install pygments.rb

# Add pandoc
# https://github.com/advancedtelematic/dockerfiles/blob/master/doctools/Dockerfile
#RUN apk add --no-cache cmark --repository http://nl.alpinelinux.org/alpine/edge/testing && \
#    apk add --no-cache --allow-untrusted pandoc --repository https://conoria.gitlab.io/alpine-pandoc/

ENV HOME=/home/jenkins

ENV GRADLE_USER_HOME=/home/jenkins/.gradle

ARG DTC_VERSION
RUN curl -LO https://github.com/docToolchain/docToolchain/releases/download/${DTC_VERSION}/docToolchain-${DTC_VERSION#?}.zip \
    && unzip docToolchain-${DTC_VERSION#?}.zip \
    && mv docToolchain-${DTC_VERSION#?} docToolchain \
    && rm docToolchain-${DTC_VERSION#?}.zip \
    && cd docToolchain \
    # This is a workaround to suppress the initialization phase of docToolchain.  \
    # We should consider a '--no-init' option in the future.
    && cp template_config/Config.groovy . \
    && umask g+w  \
    && ./gradlew tasks  \
    && ./gradlew dependencies \
    && ./gradlew generatePDF \
    && chmod -R o=u $GRADLE_USER_HOME  \
    && chmod -R g=u $GRADLE_USER_HOME  \
    && rm -r $GRADLE_USER_HOME/daemon  \
    && chmod -R o=u $HOME

# This is for interactive usage
ENV PATH="/home/jenkins/docToolchain/bin:${PATH}"
# This is for regular login
RUN echo "append_path \"/home/jenkins/docToolchain/bin\"" >> /etc/profile
# This is for SSH Login
RUN echo "PATH=${PATH}" > /home/jenkins/.ssh/environment
# While running the /usr/local/bin/setup-sshd script extends this file - make sure it exists and can be written by enyone
RUN echo "PATH=${PATH}" >> /etc/environment && chmod 666 /etc/environment
