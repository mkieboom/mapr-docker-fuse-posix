# MapR FUSE POSIX Client running in a Docker container
#
# VERSION 0.1 - not for production, use at own risk
#

#
# Use a CentOS 7 image as the base
FROM centos:7.3.1611

MAINTAINER mkieboom @ mapr.com

# Set the default MapR and MEP version, but allow overriding them using build arguments
ARG MAPR_VERSION=5.2.2
ENV MAPR_VERSION ${MAPR_VERSION}
ARG MEP_VERSION=3.0.1
ENV MEP_VERSION ${MEP_VERSION}

# Configure MapR Repository
RUN printf "[maprtech] \n\
name=MapR Technologies \n\
baseurl=http://package.mapr.com/releases/v${MAPR_VERSION}/redhat/ \n\
enabled=1 \n\
gpgcheck=0 \n\
protect=1 \n\
 \n\
[maprecosystem] \n\
name=MapR Technologies \n\
baseurl=http://package.mapr.com/releases/MEP/MEP-${MEP_VERSION}/redhat \n\
enabled=1 \n\
gpgcheck=0 \n\
protect=1" > /etc/yum.repos.d/maprtech.repo

# Install Open JDK
RUN yum install -y java-1.8.0-openjdk

# Install the mapr gpg key
RUN rpm --import http://package.mapr.com/releases/pub/maprgpg.key

# Install the FUSE Basic client
RUN yum install -y mapr-posix-client-basic

# Add the launch script and make it executable
ADD ./launch.sh /launch.sh
RUN chmod +x /launch.sh

CMD /launch.sh