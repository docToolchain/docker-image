FROM eclipse-temurin:11-jdk-focal

SHELL ["/bin/bash", "-c"]

RUN addgroup --system dtcgroup && adduser --system dtcuser --ingroup dtcgroup

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y build-essential curl wget zip unzip git bash graphviz python3 ruby-dev \
    python3-pygments libyaml-dev ttf-dejavu
RUN gem update --system && gem install rdoc --no-document && gem install pygments.rb


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
