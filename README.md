# mapr-docker-fuse-posix

##### Clone the project
```
git clone https://github.com/mkieboom/mapr-docker-fuse-posix  
cd mapr-docker-fuse-posix  
```

##### Build the container  
# You can override the default MapR and MEP version by providing them as build arguments.
```
docker build -t mkieboom/mapr-docker-fuse-posix --build-arg MAPR_VERSION=5.2.2 --build-arg MEP_VERSION=3.0.1 .
```

##### Launch the container 
```
# Change the MapR specific command line parameters to reflect your MapR cluster 
  
docker run -it \
--cap-add SYS_ADMIN \
--cap-add SYS_RESOURCE \
--device /dev/fuse \
-e MAPR_VERSION=5.2.2 \
-e MEP_VERSION=3.0.1 \
-e MAPR_CLUSTER=demo.mapr.com \
-e MAPR_CLDB_HOSTS=192.168.168.1 \
-e MAPR_ZOOKEEPER_HOSTS=192.168.168.1 \
-e MAPR_CONTAINER_USER=mapr \
-e MAPR_CONTAINER_GROUP=mapr \
-e MAPR_CONTAINER_UID=5000 \
-e MAPR_CONTAINER_GID=5000 \
-e MAPR_MOUNT_PATH=/mapr \
mkieboom/mapr-docker-fuse-posix
```
##### Launch container as deamon with auto restart  
```
# Change the MapR specific command line parameters to reflect your MapR cluster 
  
docker run -d \
--restart always \  
--cap-add SYS_ADMIN \
--cap-add SYS_RESOURCE \
--device /dev/fuse \
-e MAPR_VERSION=5.2.2 \
-e MEP_VERSION=3.0.1 \
-e MAPR_CLUSTER=demo.mapr.com \
-e MAPR_CLDB_HOSTS=192.168.168.1 \
-e MAPR_ZOOKEEPER_HOSTS=192.168.168.1 \
-e MAPR_CONTAINER_USER=mapr \
-e MAPR_CONTAINER_GROUP=mapr \
-e MAPR_CONTAINER_UID=5000 \
-e MAPR_CONTAINER_GID=5000 \
-e MAPR_MOUNT_PATH=/mapr \
mkieboom/mapr-docker-fuse-posix
```

##### Use psql to connect  
```
# Install psql client on any other machine  
yum install -y postgresql
```

##### Connect to remote database  
```
psql -U mapr -h maprn01 -p 5432
```

##### Basic SQL testing
```
CREATE SCHEMA test;
CREATE TABLE test.test (coltest varchar(20));
insert into test.test (coltest) values ('It works!');
SELECT * from test.test;
```
