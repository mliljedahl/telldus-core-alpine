# telldus-core-alpine
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/mliljedahl/telldus-core-alpine)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/mliljedahl/telldus-core-alpine)
![Docker Pulls](https://img.shields.io/docker/pulls/mliljedahl/telldus-core-alpine)

Docker image running Alpine Linux that provides a telldusd interface to be used to communicate with your tellstick.

## Installation

The recommended way for running the image is to include it to your existing `docker-compose.yaml` file so only linked containers can talk to it.

### Docker Compose

Here is an example using docker-compose:

```
  telldus-core-alpine:
    image: mliljedahl/telldus-core-alpine:1.0.2
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

### Easy installation

Easiest option is to run the `docker-compose.yaml` file. **This is far from recommended** because the telldusd ports (50800-50801) will be exposed to the host network (0.0.0.0). Only use this method for testing.

```
$ docker-compose up -d
```

### Docker run

```
$ docker run --name telldus-core-alpine -v ./data/tellstick.conf:/etc/tellstick.conf:ro --device=/dev/bus/usb:/dev/bus/usb:rwm -d mliljedahl/telldus-core-alpine:1.0.2
```

## Home Assistant

Here is the config that needs to be added or changed in `configuration.yaml` for home-assistant:

```
# Example configuration.yaml entry with the TellStick add-on
tellstick:
  host: telldus-core-alpine
  port: [50800, 50801]
```

## TellStick configuration

The provided `data/tellstick.conf` is the default config and need to be updated for your sensors and devices. If you have this already setup in for example `/etc/tellstick.conf` you can include this directly from the *docker-compose.yaml* file by editing the *volume*; 

```
    volumes:
      - /etc/tellstick.conf:/etc/tellstick.conf:ro
``` 

### Example file

This is an example of `tellstick.conf`. The serial should be the same for all tellstick devices, you can verify that by checking the outout from `sudo lsusb -v`.

```
user="root"
group="plugdev"
ignoreControllerConfirmation="false"

controller {
  id=1
  type=2
  serial="A7Z2Z64B"
}

device {
  id=1
  name="livingroom-01"
  protocol="arctech"
  model="selflearning-switch"
  parameters {
    house="1"
    unit="1"
  }
}
```

### Manual testing

The docker image provides the `tdtool` command and it can be used like; 

```
$ docker exec -it telldus-core-alpine tdtool -f 1
Turning off device 1, livingroom-01 - Success
```

For more information see; `docker exec -it telldus-core-alpine tdtool -h`

## Reporting bugs

Please report bugs in the [issue tracker](https://github.com/mliljedahl/telldus-core-alpine/issues).

## Project home

The project can be found on [github](https://github.com/mliljedahl/telldus-core-alpine)

## License

Distributed under the Apache 2.0 License. See [LICENSE](https://github.com/mliljedahl/telldus-core-alpine/blob/master/LICENSE) for more information.
