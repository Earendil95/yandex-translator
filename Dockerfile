FROM ruby:2.3

ENV LANG C.UTF-8
ENV TEACHBASE_HOST https://go.teachbase.ru/
ENV RACK_ENV production

RUN apt-get update && apt-get install -y sudo nginx
COPY ./config/nginx/default.conf /etc/nginx/sites-available/default

RUN mkdir -p /webapps/yandex_proxy
WORKDIR /webapps/yandex_proxy

# RUN bundle config --global frozen 1

COPY Gemfile /webapps/yandex_proxy
COPY Gemfile.lock /webapps/yandex_proxy

RUN gem install bundler && bundle install --without development test

COPY . /webapps/yandex_proxy

RUN mkdir -p shared/pids && mkdir -p shared/log && mkdir -p shared/sockets

EXPOSE 443

CMD /bin/sh bin/entrypoint.sh
