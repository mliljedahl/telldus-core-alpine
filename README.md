# telldus-core-alpine
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/mliljedahl/telldus-core-alpine)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/mliljedahl/telldus-core-alpine)
![Docker Pulls](https://img.shields.io/docker/pulls/mliljedahl/telldus-core-alpine)

## Installation

The recommended way for running the image is to include it to your existing docker-compose.yml file so only linked containers can talk to it.

### Docker Compose

Here is an example using docker-compose.yml:

```
  telldus-core-alpine:
    image: mliljedahl/telldus-core-alpine:1.0.0
    container_name: telldus-core-alpine
    restart: unless-stopped
    devices:
      - /dev/bus/usb:/dev/bus/usb:rwm
    volumes:
      - ./data/tellstick.conf:/etc/tellstick.conf:ro
    expose:
      - "50800"
      - "50801"
```

### Home Assistant

Here is the config that needs to be added or changed in `configuration.yaml` for home-assistant:

```
# Example configuration.yaml entry with the TellStick add-on
tellstick:
  host: telldus-core-alpine
  port: [50800, 50801]
```

### Easy installation

Easiest option is to run the `docker-compose.yaml` file. **This is far from recommended** because the telldusd ports (50800-50801) will be exposed to the host network (0.0.0.0). 

```
$ docker-compose up -d
```

### Docker run

```
$ docker run --name telldus-core-alpine -v ./data/tellstick.conf:/etc/tellstick.conf:ro --device=/dev/bus/usb:/dev/bus/usb:rwm -d mliljedahl/telldus-core-alpine:1.0.0
```

## Reporting bugs

Please report bugs in the [issue tracker](https://github.com/mliljedahl/telldus-core-alpine/issues).

## License

Distributed under the Apache 2.0 License. See [LICENSE](https://github.com/mliljedahl/telldus-core-alpine/blob/master/LICENSE) for more information.
