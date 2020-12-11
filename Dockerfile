FROM nginx
RUN apt-get clean && apt-get update && apt-get install -y spawn-fcgi fcgiwrap
RUN sed -i 's/www-data/nginx/g' /etc/init.d/fcgiwrap
RUN chown nginx:nginx /etc/init.d/fcgiwrap
ADD ./vhost.conf /etc/nginx/conf.d/default.conf
RUN mkdir /usr/lib/cgi-bin -p
ADD ./index.pl /usr/lib/cgi-bin/index.pl
RUN chmod 755 /usr/lib/cgi-bin/index.pl
CMD /etc/init.d/fcgiwrap start \
    && nginx -g 'daemon off;'

