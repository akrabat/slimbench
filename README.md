# Slim Benchmarks

Run a simple "Hello World" Slim application for v2, v3 & v4 and [log the reports to a CouchDB instance][1].

## Running on a fresh Ubuntu 16.04 (e.g. Amazon AWS)

```bash
$ git clone https://github.com/akrabat/slimbench.git
$ cd slimbench
$ ./setup_ubuntu.sh
```

Run test:

```bash
$ export AUTHOR="Your Name Here" && docker-compose up
```

## Notes on running manually

```bash
$ git clone https://github.com/akrabat/slimbench.git
$ cd slimbench
$ cd v2-empty && composer update -a --no-dev
$ cd v3-empty && composer update -a --no-dev
$ cd v4-empty && composer update -a --no-dev
```

Run test:

```bash
$ export AUTHOR="Your Name Here" && docker-compose up
```

Alternatively, to run siege locally:

    alias siege="docker run -ti --rm -u $UID -v `pwd`:/data -v ~/.siegerc:/root/.siegerc centminmod/docker-centos6-siege siege"
    siege -q -t 30s -c 10 -b http://172.17.0.1:8888/v2-empty/public && siege -q -t 30s -c 10 -b http://172.17.0.1:8888/v3-empty/public && siege -q -t 30s -c 10 -b http://172.17.0.1:8888/v4-empty/public

    (check IP address as Docker sets it)



[1]: https://github.com/akrabat/slimbench/blob/master/bin/siege.sh#L35-L36
