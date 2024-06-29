#!/bin/bash

apt-get update
apt-get install -y subversion ssh build-essential zlib1g-dev

mkdir -p /home/redmine/.ssh/
#cp /home/redmine/_ssh/* /home/redmine/.ssh/
chown -R redmine:redmine /home/redmine/.ssh/
#chmod 0400 /home/redmine/.ssh/id_rsa

. /opt/bitnami/scripts/redmine-env.sh
. /opt/bitnami/scripts/libredmine.sh

info "Install required gems."

cd /opt/bitnami/redmine/

export RAILS_ENV="$REDMINE_ENV"

run_as_user redmine bundle config set frozen false
run_as_user redmine bundle install
run_as_user redmine bundle config unset frozen
