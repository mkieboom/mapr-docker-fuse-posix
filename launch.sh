#!/bin/bash

echo "###################################################################"
echo "########      MapR FUSE POSIX configuration details        ########"
echo "###################################################################"
echo MAPR_VERSION:		$MAPR_VERSION
echo MEP_VERSION:		$MEP_VERSION
echo MAPR_CLUSTER:		$MAPR_CLUSTER
echo MAPR_CLDB_HOSTS:	$MAPR_CLDB_HOSTS
echo MAPR_ZOOKEEPER_HOSTS:	$MAPR_ZOOKEEPER_HOSTS
echo MAPR_MOUNT_PATH:	$MAPR_MOUNT_PATH
echo MAPR_CONTAINER_USER:	$MAPR_CONTAINER_USER
echo MAPR_CONTAINER_GROUP:	$MAPR_CONTAINER_GROUP
echo MAPR_CONTAINER_UID:	$MAPR_CONTAINER_UID
echo MAPR_CONTAINER_GID: 	$MAPR_CONTAINER_GID
echo
echo "Running MapR FUSE POSIX Client launch script now."
echo

# Add the mapr user and group
groupadd -g 2000 mapr
useradd -u 2000 -g 2000 mapr

# Configure the client (-c specifies client deployment)
/opt/mapr/server/configure.sh -N $MAPR_CLUSTER -C $MAPR_CLDB_HOSTS -Z $MAPR_ZOOKEEPER_HOSTS -c

# Create the mountpoint and start the FUSE service
mkdir /$MAPR_MOUNT_PATH
/etc/init.d/mapr-posix-client-basic start

# Open en bash to keep the container alive
/bin/bash