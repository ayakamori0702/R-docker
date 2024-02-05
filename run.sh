#!/bin/sh

docker run \
  -it \
  --rm \
  -v $(pwd):/mnt \
  --workdir=/mnt \
  amori/r-base:v0.0 \
  /bin/bash