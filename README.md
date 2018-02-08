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
- `/app/flaskbb/flaskbb/themes` - *(Optional)* Use this to override the FlaskBB `themes` directory
- `/app/flaskbb/flaskbb/static/emoji` - *(Optional)* Downloaded emojis

## Download emojis

To download emojis to use in your FlaskBB instance, you need to run the
`flaskbb download-emojis` command from a container with the `emoji` volume
mounted to your host system. FlaskBB must be restarted after the emojis have
been downloaded.

### With a running container

	docker exec -ti <container name> /bin/ash -c "flaskbb --config config/flaskbb.cfg download-emojis"

### With a fresh container

````
docker run -ti --rm \
	-v $(pwd)/data:/app/data -v $(pwd)/config:/app/config \
	-v $(pwd)/emoji:/app/flaskbb/flaskbb/static/emoji \
	haliphax/flaskbb:latest \
	/bin/ash -c "flaskbb --config config/flaskbb.cfg download-emojis"
````

## Image

The image is available as `haliphax/flaskbb:latest` on the
[Docker hub](https://hub.docker.com/r/haliphax/flaskbb/).
