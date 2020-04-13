FROM phusion/passenger-ruby26:1.0.6

# phusion/passenger-ruby26 が提供する初期化プロセスを利用
CMD ["/sbin/my_init"]

RUN apt-get update -qq && \
    apt-get install -y \
    postgresql-client graphviz tzdata bsdmainutils \
    automake autoconf libreadline-dev libncurses-dev libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev unzip curl && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# passenger の設定を反映
RUN rm /etc/nginx/sites-enabled/default
COPY --chown=app:app passenger.prod.conf /etc/nginx/sites-enabled/passenger.prod.conf

# passenger の有効化
RUN rm -f /etc/service/nginx/down

USER app
SHELL ["/bin/bash", "-lc"]
RUN echo -e '\n. $HOME/.bash_profile' >> ~/.bashrc

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf && \
    cd ~/.asdf && \
    git checkout "$(git describe --abbrev=0 --tags)" && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bash_profile && \
    echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bash_profile && \
    echo "legacy_version_file = yes" >> ~/.asdfrc

RUN asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git && \
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring && \
    asdf plugin-add yarn

COPY --chown=app:app . /home/app/web
WORKDIR /home/app/web
RUN asdf install

RUN bundle install --without test development
RUN yarn && bundle exec rails webpacker:compile && rm -rf node_modules
