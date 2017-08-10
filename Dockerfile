FROM centos:latest

MAINTAINER skagalwala

# install crontabs
RUN yum -y update
RUN yum -y install crontabs

# comment out PAM
RUN sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/crond

#Add your cron file
ADD cron /etc/cron.d/cron_test
RUN chmod 0644 /etc/cron.d/cron_test

#This will add it to the cron table (crontab -e)
RUN crontab /etc/cron.d/cron_test

CMD crond && tail -f /dev/null