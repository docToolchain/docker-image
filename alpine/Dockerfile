FROM alpine:3.7


ENV SDKMAN_DIR=/root/.sdkman

RUN	echo "add needed tools" && \
    apk add curl wget zip unzip git bash

SHELL ["/bin/bash", "-c"]
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN echo "Install sdkman" &&\
    curl -s "https://get.sdkman.io" | bash

RUN echo "$HOME"
RUN chmod +x $HOME/.sdkman/bin/sdkman-init.sh
RUN $HOME/.sdkman/bin/sdkman-init.sh


RUN	echo "Install java, groovy" && \
    source $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk install java 8.0.192-zulu && \
    sdk install groovy 2.5.5

RUN mkdir /home/project

WORKDIR $DT_HOME/docToolchain

VOLUME /home/project

ENTRYPOINT bash
