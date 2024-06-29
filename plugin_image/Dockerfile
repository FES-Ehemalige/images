FROM bitnami/redmine:5.1.3-debian-12-r0

COPY setup.sh /setup.sh
COPY Gemfile.local /opt/bitnami/redmine/
RUN chmod a+x /setup.sh && bash setup.sh

