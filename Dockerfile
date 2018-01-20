FROM python:2.7-alpine
MAINTAINER haliphax
EXPOSE 5000
VOLUME /app/data /app/config /app/flaskbb/flaskbb/themes /app/flaskbb/flaskbb/static/emoji
WORKDIR /app
ADD ./flaskbb /app/flaskbb
RUN /bin/ash -c " \
	mkdir -p /app/plugins /usr/local/lib/python2.7/site-packages/logs \
	&& apk -U add gcc musl musl-dev zlib zlib-dev jpeg jpeg-dev \
	&& pip install -U gunicorn flaskbb-plugin-proxyfix flaskbb-plugin-private-memberlist ./flaskbb \
	&& flaskbb translations compile"
RUN apk del gcc musl-dev zlib-dev jpeg-dev
CMD /bin/ash -c " \
	pip install -U --no-deps ./flaskbb; \
	flaskbb --config config/flaskbb.cfg celery worker \
		& flaskbb --config config/flaskbb.cfg server start --host 0.0.0.0 --port 5000"
