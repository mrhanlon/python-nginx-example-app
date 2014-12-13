FROM mrhanlon/python-nginx:latest

MAINTAINER Matthew R Hanlon <mrhanlon@gmail.com>

# setup project code
COPY . /project
WORKDIR /project

# install any dependencies
RUN pip install -r requirements.txt

# configure nginx, uwsgi, supervisord
# sets nginx to run interactively for supervisord, removes the default nginx
# site, and moves your nginx and supervisord configuration in place
RUN \
  echo "daemon off;" >> /etc/nginx/nginx.conf \
  && rm /etc/nginx/sites-enabled/default \
  && ln -s /project/docker_config/nginx_app.conf /etc/nginx/sites-enabled/ \
  && ln -s /project/docker_config/supervisor_app.conf /etc/supervisor/conf.d/

EXPOSE 80 443
CMD ["supervisord", "-n"]
