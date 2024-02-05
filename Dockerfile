# Base R image
FROM rocker/r-base:4.3.1

USER root

RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    r-cran-tidyverse \
    cmake

RUN apt-get install -y python3 \
    python3-pi