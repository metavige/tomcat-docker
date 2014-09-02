# VERSION 0.0.1
FROM ubuntu
MAINTAINER metavige "metavige@gmail.com"

# update apt, install ssh server
RUN echo "deb http://tw.archive.ubuntu.com/ubuntu/ trusty main universe"> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd

# root ssh passwd
RUN echo "root:123456" | chpasswd 

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

# automatically accept the Oracle license:
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y vim wget curl oracle-java7-installer tomcat7

RUN apt-get install -y oracle-java7-set-default
RUN apt-get clean

# JAVA_HOME
RUN update-java-alternatives -s java-7-oracle
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle">> /etc/environment
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle">> /etc/default/tomcat7

EXPOSE 22

EXPOSE 8080

ENTRYPOINT service tomcat7 start && /usr/sbin/sshd -D