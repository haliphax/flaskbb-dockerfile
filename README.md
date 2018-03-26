# flaskbb-dockerfile

Containerized installation of FlaskBB. Includes `gunicorn`,
[flaskbb-plugin-proxyfix](https://github.com/haliphax/flaskbb-plugin-proxyfix),
[flaskbb-plugin-private-memberlist](https://github.com/haliphax/flaskbb-plugin-private-memberlist),
and an exported volume for adding custom themes. Can be used in a
docker-compose application along with a
[redis:alpine](https://hub.docker.com/r/library/redis/tags/alpine/) image (or
other redis image).

For an example configuration, see the
[haliphax/flaskbb-docker-compose-example](https://github.com/haliphax/flaskbb-docker-compose-example)
project.

## Ports

- 5000 - This is the port the gunicorn HTTP server listens on

## Volumes

- `/app/config` - Should contain your `flaskbb.cfg` file
- `/app/data` - Should contain your `flaskbb.sqlite` file
- `/usr/local/lib/python2.7/site-packages/flaskbb/themes` - *(Optional)* Use this to override the FlaskBB `themes` directory

## Image

The image is available as `haliphax/flaskbb:latest` on the
[Docker hub](https://hub.docker.com/r/haliphax/flaskbb/).
