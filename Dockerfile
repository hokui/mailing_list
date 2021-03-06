FROM hokui/ruby_nginx_base

RUN apt-get -yqq install git-core zlib1g-dev sqlite3 libsqlite3-dev

WORKDIR /tmp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --jobs=4

ADD . /var/app
WORKDIR /var/app

ENV RAILS_ENV=production

EXPOSE 8002

VOLUME ["/var/app/log"]

ENTRYPOINT ["bash", "run.sh"]
