FROM python:2.7-alpine
MAINTAINER haliphax
WORKDIR /app
ADD ./flaskbb /app/flaskbb
RUN /bin/ash -c " \
	for x in config plugins; do mkdir \$x; done; \
	mkdir -p /app/.local/lib/python2.7/site-packages/logs; \
	chmod 777 /app/.local/lib/python2.7/site-packages/logs; \
	adduser -D -h /app -s /bin/ash flaskbb; \
	chown -R flaskbb:flaskbb /app; \
	apk -U add redis gcc musl musl-dev zlib zlib-dev jpeg jpeg-dev; \
	pip install -U pip; \
	su flaskbb -c 'pip install --user ./flaskbb'; \
	apk del gcc musl-dev zlib-dev jpeg-dev"
EXPOSE 5000
VOLUME /app/data /app/config /app/flaskbb/flaskbb/themes
ADD ./plugins /app/plugins
RUN su flaskbb -c "for x in ./plugins/*; do pip install --user \$x; done"
CMD /bin/ash -c " \
	su flaskbb -c 'pip install --user --no-deps -U ./flaskbb'; \
	redis-server \
		& su flaskbb -c '.local/bin/flaskbb --config config/flaskbb.cfg celery worker' \
		& su flaskbb -c '.local/bin/flaskbb --config config/flaskbb.cfg run -h 0.0.0.0 -p 5000 --with-threads'"
