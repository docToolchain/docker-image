#!/bin/sh
DOCKERHUB_USERNAME=ehmkah
DTC_VERSION=v2.1.0

docker build \
  -t ${DOCKERHUB_USERNAME}/alpine-with-pandoc:${DTC_VERSION} \
  alpine-with-pandoc
