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

RUN     git clone --branch ng https://github.com/docToolchain/docToolchain.git  && \
        cd docToolchain && \
        git fetch --tags && \
        git checkout v2.0.5 && \
        git submodule update -i && \
        # remove .git folders
        rm -rf `find -type d -name .git` && \
        umask g+w && \
        ./gradlew tasks && \
        ./gradlew dependencies && \
        ./gradlew generatePDF && \
        rm -r $GRADLE_USER_HOME/daemon

# This is for interactive usage
ENV PATH="/home/jenkins/docToolchain/bin:${PATH}"
# This is for regular login
RUN echo "append_path \"/home/jenkins/docToolchain/bin\"" >> /etc/profile
# This is for SSH Login
RUN echo "PATH=${PATH}" > /home/jenkins/.ssh/environment
