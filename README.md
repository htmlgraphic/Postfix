## Postfix Docker

Postfix is a very nice mail courier service, enjoyed by many. This repo will give you a turn key, fully functional build of a Docker container for use in production or your dev environment.

---

## Quick Start
```bash
	$ git clone https://github.com/htmlgraphic/Postfix.git && cd Postfix
	$ make
	$ make build
```

___

### Repo Breakdown

##### Test Driven Development

**CircleCI** - Test the Dockerfile process, can the container be built the correctly? Verify the build process with a number of tests. Currently with this service no code can be tested on the running container. Data can be echo and available grepping the output via `docker logs | grep value`

[![Circle CI](https://circleci.com/gh/htmlgraphic/Postfix/tree/master.svg?style=svg&circle-token=b99a13800c40caa2cc8bafa36258acccf038b8aa)](https://circleci.com/gh/htmlgraphic/Postfix/tree/master)


**Shippable** - Run tests on the actual built container. These tests ensure the scripts have been setup properly and the service can start with parameters defined. If any test(s) fail the system should be reviewed closer.

[![Build Status](https://api.shippable.com/projects/54986113d46935d5fbc0d2ec/badge?branchName=master)](https://app.shippable.com/projects/54986113d46935d5fbc0d2ec/builds/latest) 


## Build Breakdown

```shell
Postfix
├── app/                     # → App conf to manage application on container
│   ├── preseed.txt   			 # → Params used on initial Postfix setup
│   ├── run.sh            	 # → Setup apache, move around conf files, start process on container
│   ├── supervisord.conf   	 # → Supervisor is a system which monitors and controls a number of processes
│   ├── virtual   					 # → Map `root` to an actual email
│   ├── run.sh               # → Setup apache, conf files, and start process on container
│   ├── sample.conf          # → Located within `/data/apache2/sites-enabled` duplicate / modify to add domains
│   └── supervisord          # → Supervisor is a system which monitors and controls a number of processes
├── .env.example             # → Useful environment variables 
├── .circleci/
│   └── config.yml           # → CircleCI 2.0 Config
├── docker-compose.yml       # → Production build
├── Dockerfile               # → Uses a basefile build to help speed up the docker container build process
├── Makefile                 # → Build command shortcuts
├── shippable.yml            # → Shippable configuration
└── tests/
    ├── build_tests.sh       # → Build test processes
    └── shunit2-2.1.7.tar.gz # → sh unit teesting
```


---

* To use [CircleCI](https://circleci.com/gh/htmlgraphic/Docker) review the `circle.yml` file.
* To use [Shippable](http://shippable.com) review the `shippable.yml` file. This service will use a `circle.yml` file configuration but for the unique features provided by **Shippable** it is best to use the deadicated `shippable.yml` file. This service will fully test the creation of your container and can push the complete image to your private Docker repo if you desire.
