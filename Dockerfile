FROM python:2.7-alpine
MAINTAINER haliphax
EXPOSE 5000
VOLUME /app/data /app/config /usr/local/lib/python2.7/site-packages/flaskbb/flaskbb/themes
WORKDIR /app
ADD ./flaskbb /app/flaskbb
RUN /bin/ash -c " \
	mkdir -p /app/plugins /usr/local/lib/python2.7/site-packages/logs \
	&& apk -U add gcc musl musl-dev zlib zlib-dev jpeg jpeg-dev \
	&& pip install -U gunicorn ./flaskbb \
	&& apk del gcc musl-dev zlib-dev jpeg-dev \
	&& flaskbb translations compile \
	"
ADD ./wsgi.py /app/
CMD /bin/ash -c " \
	pip install -U --no-deps ./flaskbb; \
	gunicorn -w 4 -b 0.0.0.0:5000 wsgi:flaskbb \
	"
