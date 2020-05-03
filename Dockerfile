FROM phusion/passenger-customizable:1.0.9

CMD ["/sbin/my_init"]

# configure ruby 2.6.5 and nodejs Debnium (v10)
RUN /pd_build/ruby-2.6.5.sh
RUN /pd_build/nodejs.sh

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
    apt-get install -y \
    postgresql-client graphviz tzdata bsdmainutils \
    automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev unzip curl && \
    apt-get install -y --no-install-recommends yarn && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm /etc/nginx/sites-enabled/default
COPY --chown=app:app passenger.prod.conf /etc/nginx/sites-enabled/passenger.prod.conf

RUN rm -f /etc/service/nginx/down

USER app

COPY --chown=app:app . /home/app/web
WORKDIR /home/app/web

ENV RAILS_ENV=production
RUN bundle install --without test development
RUN yarn && bundle exec rails webpacker:compile && rm -rf node_modules
