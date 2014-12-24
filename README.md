##Quick Start
```bash
    $ git clone https://github.com/htmlgraphic/Postfix.git && cd Postfix
    $ make
    $ make build
```

##Postfix Docker

Postfix is a very nice mail courier service, I enjoy using. This repo will give you a turn key, fully functional build of a Docker container for use in production.

This build is part of a larger set of [Dockerfiles](https://github.com/htmlgraphic/Docker) used to run services either locally within Docker or on a [CoreOS Cluster](https://github.com/htmlgraphic/coreos) managed with Fleetctl.

#####Test Driven Development
Consistent testing is important when making any edits, large or small. By using test driven development you can save a great deal of time making sure no buggy code makes it into production environments. This build uses CircleCI and Shippable to test the final build.

**[CircleCI](https://circleci.com/gh/htmlgraphic/Postfix)** - Test the Dockerfile process, can the container be built the correctly? Verify the build process with a number of tests. Currently no code can be tested on the running container. Data can be echo and available grepping the output via `docker logs | grep value`
[![Circle CI](https://circleci.com/gh/htmlgraphic/Postfix/tree/develop.svg?style=svg&circle-token=b99a13800c40caa2cc8bafa36258acccf038b8aa)](https://circleci.com/gh/htmlgraphic/Postfix/tree/develop)

**[Shippable](https://shippable.com)** - Run tests on the actual built container. These tests ensure the scripts have been setup properly and that postfix can start with parameters defined. If any test(s) fail the system should be reviewed closer.
[![Build Status](https://api.shippable.com/projects/54986113d46935d5fbc0d2ec/badge?branchName=master)](https://app.shippable.com/projects/54986113d46935d5fbc0d2ec/builds/latest)

####Postfix Container
*   **.dockerignore** - Files that should be ignored during the build process - [best practices](https://docs.docker.com/articles/dockerfile_best-practices/#use-a-dockerignore-file)
*   **build_tests.sh** - Tests ran with test driven development service Shippable
*   **circle.yml** - Tests ran with test driven development service CircleCI
*   **Dockerfile** - Uses a basefile build to help speed up the docker container build process
*   **Makefile** - A helpful file used to streamline the creation of containers
*   **postfix.sh** - Used by supervisord.conf to start Postfix
*   **run.sh** - Setup apache, move around conf files, start process on container
*   **preseed.txt** - Params used on initial Postfix setup
*   **run.sh** - Setup apache, move around conf files, start process on container
*   **shippable.yml** - Configuration file used by Shippable to fun `build_tests.sh`
*   **supervisord.conf** - Supervisor is a client/server system that allows its users to monitor and control a number of processes on UNIX-like operating systems
*   **virtual** - Map `root` to an actual email

