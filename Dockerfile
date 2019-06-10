FROM nginx:1.15

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN apt-get update
RUN apt-get -y install curl

RUN mkdir /var/www && chmod -R g+w /var/www \
  && chmod g+rwx /var/cache/nginx /var/run /var/log \
  && chmod 0660 /etc/nginx/nginx.conf \
  && touch /var/log/nginx/error.app.log && chmod 0660 /var/log/nginx/error.app.log \
  && chgrp -R root /var/cache/nginx \
  && chown -R nginx:nginx /var/www /var/run

COPY start.sh /usr/local/bin/start.sh

RUN chmod 0760 /usr/local/bin/start.sh

RUN apt-get update && \
        apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2

RUN curl -fsSL https://packages.sury.org/php/apt.gpg | apt-key add -

RUN add-apt-repository "deb https://packages.sury.org/php/ $(lsb_release -cs) main"

RUN apt-get update && apt-get install -y php7.2-common php7.2-cli

RUN apt-get install -y nginx

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
