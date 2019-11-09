## Postfix Docker

[![Run Status](https://api.shippable.com/projects/54986113d46935d5fbc0d2ec/badge?branch=master)]()
[![CircleCI](https://circleci.com/gh/htmlgraphic/Postfix.svg?style=svg)](https://circleci.com/gh/htmlgraphic/Postfix) 


Postfix is a very nice mail courier service, enjoyed by many. This repo will give you a turn key, fully functional build of a Docker container for use in production or your dev environment.

---

## Quick Start
```bash
	> git clone https://github.com/htmlgraphic/Postfix.git && cd Postfix
	> cp .env.example .env
	> make
	> make build
```

---

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

