# haliphax/flaskbb

Containerized installation of FlaskBB. Includes a local redis server, flaskbb-plugin-proxyfix, flaskbb-plugin-private-memberlist, and an exported volume for adding custom themes.

## Ports

- 5000 - This is the port the Werkzeug HTTP server listens on

## Volumes

- /app/config - Should contain your flaskbb.cfg file
- /app/data - Should contain your flaskbb.sqlite file
- /app/flaskbb/flaskbb/themes - (Optional) Use this to override the FlaskBB themes directory
