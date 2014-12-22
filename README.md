[![Build Status](https://api.shippable.com/projects/54986113d46935d5fbc0d2ec/badge?branchName=master)](https://app.shippable.com/projects/54986113d46935d5fbc0d2ec/builds/latest) [![Circle CI](https://circleci.com/gh/htmlgraphic/Postfix/tree/develop.svg?style=svg&circle-token=b99a13800c40caa2cc8bafa36258acccf038b8aa)](https://circleci.com/gh/htmlgraphic/Postfix/tree/develop)

##Postfix Docker

Postfix is a very nice mail courier service, I enjoy using. This repo will give you a turn key, fully functional build of a Docker container for use in production.

This build is part of a larger set of [Dockerfiles](https://github.com/htmlgraphic/Docker) used to run services either locally within Docker or on a [CoreOS Cluster](https://github.com/htmlgraphic/coreos) managed with Fleetctl.

#####Test Driven Development
Consistent testing is important when making any edits, large or small. By using test driven development you can save a great deal of time making sure no buggy code makes it into production environments. This build uses CircleCI and Shippable to test the final build.

**[CircleCI](https://circleci.com/gh/htmlgraphic/Postfix)** - Test the Dockerfile process, can the container be built the correctly? Verify the build process with a number of tests. Currently no code can be tested on the running container. Data can be echo and available grepping the output via `docker logs | grep value`

**[Shippable](https://shippable.com)** - Run tests on the actual built container. These tests ensure the scripts have been setup properly and that postfix can start with parameters defined. If any test(s) fail the system should be reviewed closer.