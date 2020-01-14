FROM openjdk:8

ENV HADOOP_HOME /opt/hadoop
ENV JAVA_HOME /usr/local/openjdk-8

RUN \
    if [ ! -e /usr/bin/python ]; then ln -s /usr/bin/python2.7 /usr/bin/python; fi

ADD hadoop-3.3.0-SNAPSHOT.tar.gz /

RUN \
    mv hadoop-3.3.0-SNAPSHOT $HADOOP_HOME && \
    for user in hadoop hdfs marblejenka; do \
         useradd -U -M -d /opt/hadoop/ --shell /bin/bash ${user}; \
    done && \
    for user in root hdfs marblejenka; do \
         usermod -G hadoop ${user}; \
    done && \
    echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "export HDFS_NAMENODE_USER=root" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "PATH=$PATH:$HADOOP_HOME/bin" >> ~/.bashrc

WORKDIR /
####################################################################################

ADD *xml $HADOOP_HOME/etc/hadoop/

EXPOSE 9000 8088 9870 9864 19888 8042 8888

CMD $HADOOP_HOME/bin/hdfs namenode -format && $HADOOP_HOME/bin/hdfs namenode

