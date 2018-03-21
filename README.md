# haproxy-client

A haproxy container with custom AF error pages.

### Usage

The container does not include haproxy config, so
you must mount a config directory/config file to the 
container before starting it. Container's entrypoint
expects haproxy config to be located at `/etc/haproxy/haproxy.cfg`.

Assuming that you have created `/etc/haproxy` directory on your host
machine and put the config there, you can use the following docker-compose
file to start the service:

```yaml
---
version: '2'
services:
  haproxy:
    image: anchorfree/haproxy:v0.1.1
    container_name: vpn-haproxy
    restart: always
    network_mode: "host"
    environment:
      - TZ=US/Pacific
    ports:
      - 1444
      - 2444
      - 3444
      - 4444
      - 9000
    volumes:
      - "/etc/haproxy:/etc/haproxy"
```

Or, if you are using consul-templater, put your configs and templates
inside `/etc/consul-templater`, and you the following docker-compose file:

```
---
version: '2'
services:
  haproxy:
    image: anchorfree/haproxy:v0.1.1
    container_name: vpn-haproxy
    restart: always
    network_mode: "host"
    environment:
      - TZ=US/Pacific
    ports:
      - 1444
      - 2444
      - 3444
      - 4444
      - 9000
    volumes:
      - "/etc/haproxy:/etc/haproxy"
  consul-templater:
    image: anchorfree/consul-templater:v1.0
    container_name: consul-templater
    restart: always
    network_mode: "host"
    environment:
      - TZ=US/Pacific
    volumes:
      - "/etc/af:/output/af"
      - "/etc/haproxy:/output/haproxy"
      - "/etc/consul-templater:/etc/consul-templater"
      - "/var/run/docker.sock:/var/run/docker.sock"
```

