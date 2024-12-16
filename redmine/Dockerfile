ARG TAG

FROM bitnami/redmine:$TAG

COPY setup.sh /setup.sh
COPY Gemfile.local /opt/bitnami/redmine/

# submenu positioning fix
COPY context_menu.js /opt/bitnami/redmine/public/javascripts/context_menu.js

RUN bash setup.sh
