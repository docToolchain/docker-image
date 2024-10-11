FROM doctoolchain/doctoolchain:v3.4.1

# Azure DevOps requires root access to inject its own users/groups
USER root

# Install required dependencies for Azure DevOps
RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam \
  && apk add bash sudo shadow nodejs \
  && apk del .pipeline-deps

ENV DTC_HEADLESS=1

# Point Azure DevOps to node binary
LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/bin/node"

ENTRYPOINT []
