# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos6
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update; yum clean all
RUN yum -y install epel-release https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm http://rpms.remirepo.net/enterprise/remi-release-6.rpm; yum clean all
RUN yum -y install yum-utils
RUN yum-config-manager --enable remi-php72
RUN yum -y install httpd php php-mysql php-gd pwgen supervisor bash-completion git openssh-server psmisc tar; yum clean all
RUN yum -y update; yum clean all
ADD ./wordpress/start.sh /start.sh
ADD ./wordpress/foreground.sh /etc/apache2/foreground.sh
ADD ./wordpress/supervisord.conf /etc/supervisord.conf
ADD ./wordpress/wordpress.sql /tmp/wordpress.sql
RUN echo %sudo	ALL=NOPASSWD: ALL >> /etc/sudoers
ADD http://wordpress.org/latest.tar.gz /wordpress.tar.gz
RUN mkdir -p ~/.ssh
RUN touch ~/.ssh/known_hosts
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

# Add -C and strip-components to work around AUFS limitation for boot2docker
RUN tar xvzf /wordpress.tar.gz -C /var/www/html --strip-components=1
RUN rm -rf /var/www/html/wp-content
RUN git clone https://github.com/attackmodeninja/wordpress-base.git /var/www/html/wp-content
#RUN mv /wordpress/* /var/www/html/.
RUN chown -R apache:apache /var/www/
RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh
RUN mkdir -p /var/run/sshd

EXPOSE 80
EXPOSE 22

CMD ["/bin/bash", "/start.sh"]
