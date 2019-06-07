FROM debian:stretch

COPY start.sh /start.sh

RUN chmod 755 /start.sh

RUN apt-get update && \
        apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2

RUN curl -fsSL https://packages.sury.org/php/apt.gpg | apt-key add -

RUN add-apt-repository "deb https://packages.sury.org/php/ $(lsb_release -cs) main"

RUN apt-get update && apt-get install -y php7.2-common php7.2-cli

RUN apt-get install -y nginx

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
