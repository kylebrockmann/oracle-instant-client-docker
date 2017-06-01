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
ENV ORACLE_INSTANTCLIENT_VERSION 11.2.0.4.0
ENV ORACLE /usr/local/oracle
ENV ORACLE_HOME $ORACLE/lib/oracle/$ORACLE_INSTANTCLIENT_MAJOR/client64
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$ORACLE/lib/oracle/$ORACLE_INSTANTCLIENT_MAJOR/client64/lib
ENV C_INCLUDE_PATH $C_INCLUDE_PATH:$ORACLE/include/oracle/$ORACLE_INSTANTCLIENT_MAJOR/client64

