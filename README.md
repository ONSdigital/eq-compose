### EQ Compose

This Repo contains docker-compose scripts to launch EQ

To use these commands you will need to have Docker installed
https://docs.docker.com/docker-for-mac/install/

### Overview

Here are the various EQ services and how they relate to one another.

![EQ Component Diagram](./component-diagram.png "EQ Component Diagram")

### Start all EQ services:
```
docker-compose pull
docker-compose up
```

### Stop all running services:
```
docker-compose down
```

Below is a list of URLs for the services that will be started.

---
Service                                    | Description
-------------------------------------------|----------------------
eq-survey-register                         | http://localhost:8080
eq-survey-runner                           | http://localhost:5000
eq-survey-launcher                         | http://localhost:8000
eq-author                                  | http://localhost:3000
eq-author-api                              | http://localhost:4000
eq-publisher                               | http://localhost:9000

---

### Use a specific tag for a service:

If, for example, a specific branch from a PR is required for testing purposes,
the `docker-compose.yml` file can be modified locally by appending a tag to an image name:
```
image: onsdigital/eq-runner:branch-name
```
Then to restart running services with the new tagged service(s) `pull` down the 
image(s) from [Docker Hub](https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&q=onsdigital&starCount=0) and start all EQ services:
```
docker-compose down
docker-compose pull
docker-compose up
```
NB: a tagged image is only pushed to Docker Hub once Travis checks have completed.
