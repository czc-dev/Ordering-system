FROM phusion/passenger-ruby26:1.0.6

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y \
      postgresql-client \
      graphviz \
      nodejs yarn \
      tzdata && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /home/app/web
COPY --chown=app:app . /home/app/web
CMD rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0 -p 80
