# https://github.com/letsencrypt/letsencrypt/pull/431#issuecomment-103659297
# it is more likely developers will already have ubuntu:trusty rather
# than e.g. debian:jessie and image size differences are negligible
FROM alpine:latest
MAINTAINER Marcelo Bartsch <spam-mb+github@bartsch.cl>

#RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN apk update && apk add samba samba-common-tools dbus avahi bash && rm -f /var/cache/apk/* && sed -i 's#/bin/ash#/bin/bash#'  /etc/passwd
RUN adduser -S -D smbuser 
COPY smb.conf /etc/samba/smb.conf
COPY samba.sh /samba.sh
COPY smbd.service /etc/avahi/services/

RUN chmod +x /samba.sh
ENTRYPOINT [ "/samba.sh" ]
EXPOSE "137/tcp" "137/udp" "139/tcp" "445/tcp" 