# Semantic Navigation

Creating a semantic navigational layer on a Jetson Orin with less than 8GB RAM for an autonomous wheelchair project.

## Docker Compose Quick Reference

This project currently uses:

- `compose.yaml`: ZED SDK baseline container.

- `compose.jazzy.yaml`: Ubuntu 24.04 / ROS 2 Jazzy / Nav2 / RViz2 environment.
- `jazzy`: always-on ROS development service.
- `rviz`: optional visualization service, enabled with the `viz` profile.


### Validate configuration

Checking to make sure Mark didn't screw up on the Docker compose file

```
sudo docker compose -f compose.jazzy.yaml config
```

### Build the Jazzy image

```
sudo docker compose -f compose.jazzy.yaml build
```

Build only the Jazzy service:

```
sudo docker compose -f compose.jazzy.yaml build jazzy
```

### Start headless ROS development

Start the persistent Jazzy service in the background:

```
sudo docker compose -f compose.jazzy.yaml up -d jazzy
```

To see if it's actually running:

```
sudo docker compose -f compose.jazzy.yaml ps
```

This is how to open up a bash shell that's using the container (multiple shells are able to communicate with one another). You can open as many as you like in other terminals:

```
sudo docker compose -f compose.jazzy.yaml exec jazzy bash
```

### Start RViz2

RViz uses the Jetson desktop’s X11 display. Run this on the host before running the RViz service:

```
xhost +local:root
```

(You'll want to see: "Non-network local connections being added to access control list.)

### Start both the regular Jazzy service and the optional RViz service

```
sudo --preserve-env=DISPLAY docker compose -f compose.jazzy.yaml --profile viz up -d
```

Or, if `jazzy` service is already running, you can start only `viz` service:

```
sudo --preserve-env=DISPLAY docker compose -f compose.jazzy.yaml --profile viz up -d rviz
```

### Stop services

Since these both run on a container in the background, you'll want to shut them down.

#### Stop RViz but leave the Jazzy service running:

```
sudo docker compose -f compose.jazzy.yaml stop rviz
```

Stop and remove the Jazzy service:

```
sudo docker compose -f compose.jazzy.yaml down
```

Stop and remove Jazzy plus all services

```
sudo docker compose -f compose.jazzy.yaml --profile viz down
```

### Logs

Follow Jazzy logs:

```
sudo docker compose -f compose.jazzy.yaml logs -f jazzy
```

Follow RViz logs:

```
sudo docker compose -f compose.jazzy.yaml logs -f rviz
```

## X11 cleanup

When done using RViz, remove the temporary local-root X11 permission:

```
xhost -local:root
```
