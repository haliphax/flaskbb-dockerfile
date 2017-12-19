FROM python:2.7-alpine
MAINTAINER haliphax
EXPOSE 5000
VOLUME /app/data /app/config /app/flaskbb/flaskbb/themes
WORKDIR /app
ADD ./flaskbb /app/flaskbb
RUN /bin/ash -c " \
	mkdir -p /app/plugins /usr/local/lib/python2.7/site-packages/logs; \
	apk -U add redis gcc musl musl-dev zlib zlib-dev jpeg jpeg-dev; \
	pip install -U ./flaskbb; \
	flaskbb translations compile"
ADD ./plugins /app/plugins
RUN /bin/ash -c "for x in ./plugins/*; do pip install -U \$x; done"
RUN apk del gcc musl-dev zlib-dev jpeg-dev
CMD /bin/ash -c " \
	pip install -U --no-deps ./flaskbb; \
	redis-server \
		& flaskbb --config config/flaskbb.cfg celery worker \
		& flaskbb --config config/flaskbb.cfg run -h 0.0.0.0 -p 5000 --with-threads"
