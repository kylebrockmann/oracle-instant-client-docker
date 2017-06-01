# VERSION 1.8.1
# AUTHOR: Kyle Hans Brockmann
# DESCRIPTION: Airflow Oracle Container
# BUILD: docker build --rm -t kylebrockmann/oracle-instant-client-docker .
# SOURCE:  https://github.com/kylebrockmann/oracle-instant-client-docker

FROM centos:7
MAINTAINER kylebrockmann

# Never prompts the user for choices on installation/configuration of packages
ENV TERM linux

ENV ORACLE_INSTANTCLIENT_MAJOR 12.1
ENV ORACLE_INSTANTCLIENT_VERSION 12.2.0.1.0
ENV ORACLE /usr/local/oracle
ENV ORACLE_HOME $ORACLE/lib/oracle/$ORACLE_INSTANTCLIENT_MAJOR/client64
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$ORACLE/lib/oracle/$ORACLE_INSTANTCLIENT_MAJOR/client64/lib
ENV C_INCLUDE_PATH $C_INCLUDE_PATH:$ORACLE/include/oracle/$ORACLE_INSTANTCLIENT_MAJOR/client64
ENV PATH $PATH:$ORACLE_HOME/bin
ENV TNS_ADMIN $ORACLE_HOME/network/admin

RUN    yum update -y --nogpgcheck; yum clean all \
	&& yum install -y libaio1 cpio --nogpgcheck; yum clean all \	
	&& mkdir $ORACLE && TMP_DIR="$(mktemp -d)" && cd "$TMP_DIR" \
	&& curl -L -k https://github.com/kylebrockmann/oracle-instant-client-docker/raw/assets/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm -o basic.rpm \
    && curl -L -k https://github.com/kylebrockmann/oracle-instant-client-docker/raw/assets/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm -o devel.rpm \
    && yum localinstall basic.rpm --nogpgcheck -y; yum clean all \
	&& yum localinstall devel.rpm --nogpgcheck -y; yum clean all \
	&& rm -f basic.rpm devel.rpm \
	&& mkdir $ORACLE/lib/oracle/12.1/client64/network/admin -p
   
