FROM ruby:2.5.1-alpine3.7

# dependencies for `nokogiri`, `sqlite3`, `nodejs`, `tzdata`
RUN apk add --update \
    build-base \
    sqlite-dev \
    nodejs \
    graphviz \
    tzdata && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    rm -rf /var/cache/apk/*

WORKDIR /web
ENV BUNDLE_PATH=/bundle
ADD . .
CMD rm -f /web/tmp/pids/server.pid && bundle exec falcon serve -b http://0.0.0.0 -p 3000
