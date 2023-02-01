FROM doctoolchain/doctoolchain:v2.1.0

USER root

WORKDIR /opt
RUN wget https://github.com/jgm/pandoc/releases/download/3.0.1/pandoc-3.0.1-linux-amd64.tar.gz -O /opt/pandoc.tar.gz
RUN tar -xzf /opt/pandoc.tar.gz -C /opt
RUN rm /opt/pandoc.tar.gz
ENV PATH=$PATH:/opt/pandoc-3.0.1/bin/

USER dtcuser

WORKDIR /project

VOLUME /project

ENTRYPOINT /bin/bash
