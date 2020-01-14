# hadoop3-namenode
docker build -t marblejenka/hadoop3-namenode:java8 .
docker run -h hadoop3 -p 8042:8042 -p 8088:8088 -p 50070:50070 -p 50075:50075 -p 50090:50090 -p 9870:9870 marblejenka/hadoop3-namenode:java8

