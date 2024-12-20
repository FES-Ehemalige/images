#!/bin/bash

set -e

apt-get update
apt-get install -y subversion ssh curl wget build-essential zlib1g-dev libpq-dev default-libmysqlclient-dev

mkdir -p /home/redmine/.ssh/

. /opt/bitnami/scripts/redmine-env.sh
. /opt/bitnami/scripts/libredmine.sh

info "Install required gems."

cd /opt/bitnami/redmine/

export RAILS_ENV="$REDMINE_ENV"

run_as_user redmine bundle config set frozen false
run_as_user redmine bundle install
run_as_user redmine bundle config unset frozen

# customize ticket field naming
sed -i 's#field_due_date: Abgabedatum#field_due_date: Ende / Wiedervorlage#' config/locales/de.yml

sed -i 's#redmine_rake_execute "db:migrate" >/dev/null 2>&1#redmine_rake_execute "db:migrate"#' /opt/bitnami/scripts/libredmine.sh
sed -i 's#redmine_rake_execute "redmine:plugins:migrate" >/dev/null 2>&1#redmine_rake_execute "redmine:plugins:migrate"#' /opt/bitnami/scripts/libredmine.sh
