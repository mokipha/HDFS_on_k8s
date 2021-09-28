FROM ubuntu:18.04

ARG HADOOP_VERSION=3.3.1

USER root

RUN apt-get -y update

RUN apt-get install -y curl tar sudo openssh-server rsync hostname net-tools findutils less lsof vim bc jq

#RUN apt-get install -y software-properties-common \
#    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
#    && add-apt-repository -y ppa:webupd8team/java \
#    && apt-get update \
#    && apt-get install -y oracle-java8-installer \
#    && rm -rf /var/lib/apt/lists/* \
#    && rm -rf /var/cache/oracle-jdk8-installer
RUN apt-get install -y openjdk-8-jdk netcat gnupg libsnappy-dev && rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/hadoop && \
    curl -s https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | \
    tar -xz -C /tmp/hadoop --exclude='share/doc' && \
    mv -v /tmp/hadoop/hadoop-${HADOOP_VERSION} /usr/local/hadoop-${HADOOP_VERSION} && \
    cd /usr/local && ln -s ./hadoop-${HADOOP_VERSION} hadoop

ENV HDFS_NAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root
ENV HADOOP_HOME=/usr/local/hadoop
ENV HADOOP_COMMON_HOME=/usr/local/hadoop
ENV HADOOP_HDFS_HOME=/usr/local/hadoop
ENV HADOOP_MAPRED_HOME=/usr/local/hadoop
ENV HADOOP_YARN_HOME=/usr/local/hadoop
ENV HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR=/usr/local/hadoop/etc/hadoop
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

COPY bootstrap.sh /usr/local/hadoop/sbin/bootstrap.sh

RUN chmod 755 /usr/local/hadoop/sbin/bootstrap.sh

ENTRYPOINT ["/usr/local/hadoop/sbin/bootstrap.sh"]
