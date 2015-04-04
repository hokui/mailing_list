FROM hokui/ruby_nginx_base

RUN apt-get -yqq install git-core zlib1g-dev sqlite3 libsqlite3-dev

WORKDIR /tmp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --jobs=4

ADD . /var/app
WORKDIR /var/app

ENV RAILS_ENV=production

RUN rm -v /var/app/config/*.yml*
ADD /var/config/hokui/mailing_list/application.yml /var/app/config/application.yml
ADD /var/config/hokui/mailing_list/database.yml /var/app/config/database.yml
ADD /var/config/hokui/mailing_list/secrets.yml /var/app/config/secrets.yml

# TODO use volume container
RUN rake db:migrate

EXPOSE 8002

VOLUME ["/var/app/log"]

ENTRYPOINT ["/usr/local/bin/rails", "server", "-p", "8002"]
