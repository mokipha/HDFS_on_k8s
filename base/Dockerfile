FROM ubuntu:18.04

# hadoop_default_version=3.3.1
# jdk8

ARG HADOOP_VERSION=3.3.1

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

USER root

RUN apt-get -y update
RUN apt-get install -y curl tar sudo openssh-server rsync hostname net-tools findutils less lsof vim bc jq tzdata

RUN apt-get install -y openjdk-8-jdk netcat gnupg libsnappy-dev && rm -rf /var/lib/apt/lists/*
RUN mkdir /tmp/hadoop && \
    curl -s https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | \
    tar -xz -C /tmp/hadoop --exclude='share/doc' && \
    mv -v /tmp/hadoop/hadoop-${HADOOP_VERSION} /usr/local/hadoop-${HADOOP_VERSION} && \
    cd /usr/local && ln -s ./hadoop-${HADOOP_VERSION} hadoop

ENV HADOOP_HOME=/usr/local/hadoop
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
