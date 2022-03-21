FROM centos/systemd

LABEL maintainer="Kiterfoo for CSIESR"
COPY ./shibboleth.repo /etc/yum.repos.d/shibboleth.repo
RUN yum -y install httpd; yum install mod_ssl; yum clean all; systemctl enable httpd.service
RUN yum -y update; yum -y install wget \
    && wget https://shibboleth.net/downloads/service-provider/RPMS/repomd.xml.key \
    && rpm --import repomd.xml.key \
    && yum -y clean all
RUN yum -y install shibboleth --nogpg; yum -y clean all; systemctl enable shibd
COPY ./shibboleth/ /etc/shibboleth/
#RUN wget https://pub.federation.renater.fr/metadata/certs/renater-metadata-signing-cert-2016.pem; cp renater-metadata-signing-cert-2016.pem /etc/shibboleth/
EXPOSE 80
CMD ["/usr/sbin/init"]
