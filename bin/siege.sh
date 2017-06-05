#!/bin/bash

if [ -z "$AUTHOR" ]; then
    echo "ERROR! AUTHOR environment variable is not set";
    exit
fi
if [ "$AUTHOR" = "Your Name Here" ]; then
    echo "ERROR! AUTHOR environment variable is not set correctly";
    exit
fi

# Create a simple way to create a random string for the run_id
cat > /root/randomstring.py << EOF
import random
import string
print ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(8))
EOF

# Set up siege config file
cat > /root/.siegerc << EOF
verbose = false
logging = false
show-logfile = false
EOF


# Function to run the test
run_siege () {
    label=$1
    url=$2
    echo "Site: $label ($url):";

    echo "$label ($url)" &>> /root/siege.txt
    siege --log=/root/siege.log -q -t 30s -c 10 -b $url &>> /root/siege.txt
    curl -s -X POST -H "Content-Type: application/json" "$api_url" \
      -d "{\"label\": \"$label\", \"author\":\"$author\", \"cpu\": \"$cpu\", \"memory\": \"$memory\", \"run_id\": \"$run_id\", \"log\": \"`cat /root/siege.log | tail -n1`\"}"
}

# useful variables to log
api_url="https://openwhisk.ng.bluemix.net/api/v1/web/19FT_live/slimbench/addBenchmark"
author=$AUTHOR
cpu=`cat /proc/cpuinfo | grep model\ name | tail -n1 | cut -d ':' -f2`
memory=`cat /proc/meminfo | grep MemTotal | tail -n1 | cut -d ':' -f2`
run_id=`python /root/randomstring.py`



# Run
rm -f /root/siege.txt
rm -f /root/siege.log

run_siege "Slim 2 (empty)" "http://web/v2-empty/public/index.php"
run_siege "Slim 3 (empty)" "http://web/v3-empty/public/index.php"
run_siege "Slim 4 (empty)" "http://web/v4-empty/public/index.php"

sleep 15
cat /root/siege.txt
cat /root/siege.log
