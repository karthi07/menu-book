#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile SKIP_CSS_BUILD=true
bundle exec rake assets:clean
bundle exec rake db:migrate