ARG TAG

FROM bitnami/redmine:$TAG

COPY setup.sh /setup.sh
COPY Gemfile.local /opt/bitnami/redmine/
RUN bash setup.sh
