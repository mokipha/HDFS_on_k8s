FROM kong2303/hadoop-base:3.3.1-jdk8

ENV HDFS_NAMENODE_USER=root
ENV HDFS_DATANODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root
ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root
ENV HADOOP_COMMON_HOME=/usr/local/hadoop
ENV HADOOP_HDFS_HOME=/usr/local/hadoop
ENV HADOOP_MAPRED_HOME=/usr/local/hadoop
ENV HADOOP_YARN_HOME=/usr/local/hadoop
ENV HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR=/usr/local/hadoop/etc/hadoop

COPY bootstrap.sh /usr/local/hadoop/sbin/bootstrap.sh

RUN chmod 755 /usr/local/hadoop/sbin/bootstrap.sh

ENTRYPOINT ["/usr/local/hadoop/sbin/bootstrap.sh"]
