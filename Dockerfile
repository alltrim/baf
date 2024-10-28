FROM ubuntu:22.04

ENV TZ Europe/Kiev

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i uk_UA -c -f UTF-8 -A /usr/share/locale/locale.alias uk_UA.UTF-8

ENV LANG uk_UA.utf8

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y ttf-mscorefonts-installer fontconfig \
    && fc-cache -f -v

RUN apt-get update && apt-get install -y wget net-tools sudo locales liblcms2-2

COPY *.deb /tmp/bafdist/
RUN dpkg -i /tmp/bafdist/*.deb \
    && rm -fr /tmp/bafdist/*.deb

RUN apt-get update && apt-get install -y apache2

RUN echo "usrbaf:usrbaf" | chpasswd \
    && echo "usrbaf ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN echo "#! /bin/bash" > run.sh \
    && echo "sudo /etc/init.d/apache2 start" >> run.sh \
    && echo "/opt/BAF/x86_64/8.3.19.1529/ragent -debug" >> run.sh \
    && chmod +x run.sh

USER usrbaf

EXPOSE 1540
EXPOSE 1541
EXPOSE 1560-1591
EXPOSE 80
EXPOSE 443

VOLUME /home/usrbaf/
VOLUME /var/www/
VOLUME /etc/apache2/

CMD [ "./run.sh" ]
