#
# Oracle Java 8 Dockerfile for Usergrid
#
# https://github.com/yep/usergrid-java
#

# pull base image
FROM ubuntu:20.10

# don't ask the user when running apt-get install
ENV DEBIAN_FRONTEND noninteractive

# basic setup similar to docker's official ubuntu base image configuration
# see https://github.com/dockerfile/ubuntu
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y software-properties-common byobu curl git htop unzip vim wget tzdata && \
  echo 'Europe/Berlin' > /etc/timezone && \
  dpkg-reconfigure tzdata && \
  rm -rf /var/lib/apt/lists/*

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# default command
CMD ["bash"]
