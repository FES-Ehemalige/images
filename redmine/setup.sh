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

sed -i 's#error_can_not_reopen_issue_on_closed_version: .*$#error_can_not_reopen_issue_on_closed_version: Das Ticket ist einem abgeschlossenen Veranstaltungsjahr zugeordnet und kann daher nicht wieder geöffnet werden.#' config/locales/de.yml
sed -i 's#field_fixed_version: .*$#field_fixed_version: Veranstaltungsjahr#' config/locales/de.yml
sed -i 's#field_version: .*$#field_version: Veranstaltungsjahr#' config/locales/de.yml
sed -i 's#label_attribute_of_fixed_version: .*$#label_attribute_of_fixed_version: "%{name} des Veranstaltungsjahrs"#' config/locales/de.yml
sed -i 's#label_close_versions: .*$#label_close_versions: Vollständige Veranstaltungsjahre schließen#' config/locales/de.yml
sed -i 's#label_completed_versions: .*$#label_completed_versions: Abgeschlossene Veranstaltungsjahre#' config/locales/de.yml
sed -i 's#label_current_version: .*$#label_current_version: Gegenwärtiges Veranstaltungsjahr#' config/locales/de.yml
sed -i 's#label_latest_compatible_version: .*$#label_latest_compatible_version: Letztes kompatibles Veranstaltungsjahr#' config/locales/de.yml
sed -i 's#label_roadmap_no_issues: .*$#label_roadmap_no_issues: Keine Tickets für dieses Veranstaltungsjahr#' config/locales/de.yml
sed -i 's#label_show_completed_versions: .*$#label_show_completed_versions: Abgeschlossene Veranstaltungsjahre anzeigen#' config/locales/de.yml
sed -i 's#label_version: .*$#label_version: Veranstaltungsjahr#' config/locales/de.yml
sed -i 's#label_version_new: .*$#label_version_new: Neues Veranstaltungsjahr#' config/locales/de.yml
sed -i 's#label_version_plural: .*$#label_version_plural: Veranstaltungsjahre#' config/locales/de.yml
sed -i 's#label_version_and_files: .*$#label_version_and_files: Veranstaltungsjahre (%{count}) und Dateien#' config/locales/de.yml
sed -i 's#notice_unable_delete_version: .*$#notice_unable_delete_version: Das Veranstaltungsjahr konnte nicht gelöscht werden.#' config/locales/de.yml
sed -i 's#permission_manage_versions: .*$#permission_manage_versions: Veranstaltungsjahre verwalten#' config/locales/de.yml
sed -i 's#text_scm_command_version: .*$#text_scm_command_version: Veranstaltungsjahr#' config/locales/de.yml
sed -i 's#field_default_version: .*$#field_default_version: Standard-Veranstaltungsjahr#' config/locales/de.yml
sed -i 's#label_issue_fixed_version_updated: .*$#label_issue_fixed_version_updated: Veranstaltungsjahr aktualisiert#' config/locales/de.yml

sed -i 's#redmine_rake_execute "db:migrate" >/dev/null 2>&1#redmine_rake_execute "db:migrate"#' /opt/bitnami/scripts/libredmine.sh
sed -i 's#redmine_rake_execute "redmine:plugins:migrate" >/dev/null 2>&1#redmine_rake_execute "redmine:plugins:migrate"#' /opt/bitnami/scripts/libredmine.sh
