FROM openjdk:8

ENV HADOOP_HOME /opt/hadoop
ENV JAVA_HOME /usr/local/openjdk-8

RUN \
    if [ ! -e /usr/bin/python ]; then ln -s /usr/bin/python2.7 /usr/bin/python; fi

# If you have already downloaded the tgz, add this line OR comment it AND ...
ADD hadoop-3.2.1.tar.gz /

# ... uncomment the 2 first lines
RUN \
#    wget http://apache.crihan.fr/dist/hadoop/common/hadoop-3.1.0/hadoop-3.1.0.tar.gz && \
#    tar -xzf hadoop-3.1.0.tar.gz && \
    mv hadoop-3.2.1 $HADOOP_HOME && \
    for user in hadoop hdfs; do \
         useradd -U -M -d /opt/hadoop/ --shell /bin/bash ${user}; \
    done && \
    for user in root hdfs; do \
         usermod -G hadoop ${user}; \
    done && \
    echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "export HDFS_DATANODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "export HDFS_NAMENODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "export HDFS_SECONDARYNAMENODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "export YARN_RESOURCEMANAGER_USER=root" >> $HADOOP_HOME/etc/hadoop/yarn-env.sh && \
    echo "export YARN_NODEMANAGER_USER=root" >> $HADOOP_HOME/etc/hadoop/yarn-env.sh && \
    echo "PATH=$PATH:$HADOOP_HOME/bin" >> ~/.bashrc

WORKDIR /
####################################################################################

ADD *xml $HADOOP_HOME/etc/hadoop/

EXPOSE 8088 9870 9864 19888 8042 8888

CMD $HADOOP_HOME/bin/hdfs namenode -format && $HADOOP_HOME/bin/hdfs namenode

