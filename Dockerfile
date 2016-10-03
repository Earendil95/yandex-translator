FROM ruby:2.3

ENV LANG C.UTF-8
ENV TEACHBASE_HOST http://s1.teachbase.ru/

RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install --without development test

COPY . /usr/src/app

EXPOSE 9292

CMD ["/usr/local/bin/bundle", "exec", "puma -b \"ssl://0.0.0.0:443?key=rootCA.key&cert=rootCA.crt\""]
