FROM mono:slim

LABEL MAINTAINER="pcop <rachen@eri.com.tw>"

ENV MONO_IOMAP="all"
ENV LANG="zh_TW.UTF-8"
ENV MONO_ASPNET_WEBCONFIG_CACHESIZE=8192

#RUN sed -i 's/http:\/\/deb\./http:\/\/ftp\.tw\./g' /etc/apt/sources.list
RUN apt update
RUN apt install -y mono-xsp mono-fastcgi-server nginx curl screen

COPY src/install.sh /tmp
RUN /tmp/install.sh && rm -f /tmp/install.sh 

COPY src/bootstrap.sh /usr/bin/

EXPOSE 80 443

VOLUME ["/var/www"]

WORKDIR /var/www

ENTRYPOINT ["/usr/bin/bootstrap.sh"]

# Healthy check
HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=3 \
  CMD curl -f http://127.0.0.1 || exit 1


