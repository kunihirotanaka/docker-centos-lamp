FROM centos
MAINTAINER Kunihiro Tanaka <tanaka@sakura.ad.jp>

#RUN yum update -y
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm ;\
    wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm ;\
    wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm ;\
    rpm -ivh epel-release-6-8.noarch.rpm remi-release-6.rpm rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
ADD td.repo /etc/yum.repos.d/td.repo
RUN yum --enablerepo=remi,epel,treasuredata install openssh-server syslog httpd httpd-devel php php-devel php-pear php-mysql php-gd php-mbstring php-pecl-imagick php-pecl-memcache monit td-agent -y
ADD monit.httpd /etc/monit.d/httpd
ADD monit.sshd /etc/monit.d/sshd
ADD monit.td-agent /etc/monit.d/td-agent
ADD td-agent.conf /etc/td-agent/td-agent.conf
RUN mv /etc/ssh/sshd_config /etc/ssh/sshd_config.orig && sed 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config.orig>/etc/ssh/sshd_config
RUN chmod 755 /var/log/httpd
RUN touch /etc/sysconfig/network
