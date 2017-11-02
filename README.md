## Quick Start
```bash
	$ git clone https://github.com/htmlgraphic/Postfix.git && cd Postfix
	$ make
	$ make build
```

## Postfix Docker

Postfix is a very nice mail courier service, enjoyed by many. This repo will give you a turn key, fully functional build of a Docker container for use in production or your dev environment.

[![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/)

---

If you found this repo you are probably looking into Docker or already have knowledge as to what Docker can help you with. In this repo you will find a number of complete Dockerfile builds used in **development** and **production** environments. Listed below are the types of systems available and an explanation of each file.

### Repo Breakdown

##### Test Driven Development

**[CircleCI](https://circleci.com/gh/htmlgraphic/Postfix)** - Test the Dockerfile process, can the container be built the correctly? Verify the build process with a number of tests. Currently with this service no code can be tested on the running container. Data can be echo and available grepping the output via `docker logs | grep value`

[![Circle CI](https://circleci.com/gh/htmlgraphic/Postfix/tree/master.svg?style=svg&circle-token=b99a13800c40caa2cc8bafa36258acccf038b8aa)](https://circleci.com/gh/htmlgraphic/Postfix/tree/master)


**[Shippable](https://shippable.com)** - Run tests on the actual built container. These tests ensure the scripts have been setup properly and the service can start with parameters defined. If any test(s) fail the system should be reviewed closer.

[![Build Status](https://api.shippable.com/projects/54986113d46935d5fbc0d2ec/badge?branchName=master)](https://app.shippable.com/projects/54986113d46935d5fbc0d2ec/builds/latest) 


#### Postfix Container - Build Breakdown
* **app/preseed.txt** - Params used on initial Postfix setup
* **app/run.sh** - Setup apache, move around conf files, start process on container
* **app/supervisord.conf** - Supervisor is a client/server system that allows its users to monitor and control a number of processes on UNIX-like operating systems
* **app/virtual** - Map `root` to an actual email
* **tests/build_tests.sh** - Build processes
* **.dockerignore** - Files that should be ignored during the build process - [best practices](https://docs.docker.com/articles/dockerfile_best-practices/#use-a-dockerignore-file)
* **circle.yml** - CircleCI configuration
* **Dockerfile** - Uses a basefile build to help speed up the docker container build process
* **Makefile** - A helpful file used to streamline the creation of containers
* **shippable.yml** - Shippable configuration

---

* To use [CircleCI](https://circleci.com/gh/htmlgraphic/Docker) review the `circle.yml` file.
* To use [Shippable](http://shippable.com) review the `shippable.yml` file. This service will use a `circle.yml` file configuration but for the unique features provided by **Shippable** it is best to use the deadicated `shippable.yml` file. This service will fully test the creation of your container and can push the complete image to your private Docker repo if you desire.
