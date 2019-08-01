FROM ubuntu:18.04

RUN apt-get update -qq && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y  ansible && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV ANSIBLE_HOST_KEY_CHECKING False

CMD ["/bin/bash"]
