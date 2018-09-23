FROM alpine:3.8

RUN apk add --update --no-cache unbound
RUN rm /etc/unbound/unbound.conf
ADD unbound.conf /etc/unbound/unbound.conf
RUN unbound-checkconf

WORKDIR /etc/init.d
ENTRYPOINT ["unbound", "-d"]
