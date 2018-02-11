# Stackbench for PHP

A toolchain for benchmarking typical PHP tasks and tools

This repository is based on [Getting Started with PHP on Heroku](https://devcenter.heroku.com/articles/getting-started-with-php) - check it out.

## Usage

Deploy this app on [Heroku](https://www.heroku.com/), a private PaaS like [Dokku](https://github.com/dokku/dokku) or any
other [compatible](https://github.com/heroku/heroku-buildpack-php) runtime environment

```bash
# Getting stackbench ready on your PaaS of choice
$ git clone https://github.com/patricktruebe/stackbench-php
$ cd stackbench-php
$ git remote add bench1 <your cloud host here>
$ git push bench1

# Start the benchmark
$ export DOMAIN=http(s)://<your domain here>
$ ./stackbench.sh "$DOMAIN"
wrk2 not found. This will clone and build https://github.com/giltene/wrk2.git. Ok? [Press Enter]
[...]
$ ./stackbench.sh [domain1] ... [domain_n]
[...]
# @see Track Records for comparison
```

## Track Records

Please open a PR to share your results

* [Netcup: Nginx Load Balancer + 3 Worker Dokku Nodes VPS 500 G8](track-records/netcup-lb-3dokku.md)
