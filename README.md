# Slim Benchmarks

1. Checkout repository

2. Install composer dependencies:

        cd v2-empty && composer install
        cd v3-empty && composer install
        cd v4-empty && composer install

3. Run app

        docker-compose up

4. Results will be displayed.


Alternatively, to run siege locally:

    alias siege="docker run -ti --rm -u $UID -v `pwd`:/data -v ~/.siegerc:/root/.siegerc centminmod/docker-centos6-siege siege"
    siege -q -t 30s -c 10 -b http://172.17.0.1:8888/v2-empty/public && siege -q -t 30s -c 10 -b http://172.17.0.1:8888/v3-empty/public && siege -q -t 30s -c 10 -b http://172.17.0.1:8888/v4-empty/public

    (check IP address as Docker sets it)
