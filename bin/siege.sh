#!/bin/bash

cat > /root/randomstring.py << EOF
import random
import string
print ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(8))
EOF


api_url="https://openwhisk.ng.bluemix.net/api/v1/web/19FT_live/slimbench/addBenchmark"
author="Rob Allen"
cpu=`cat /proc/cpuinfo | grep model\ name | cut -d ':' -f2`
memory=`cat /proc/meminfo | grep MemTotal | cut -d ':' -f2`
run_id=`python /root/randomstring.py`

cat > /root/.siegerc << EOF
verbose = false
logging = false
show-logfile = false
EOF

declare -A sites
sites=(
    ["Slim 2 (empty)"]="http://web/v2-empty/public/index.php"
    ["Slim 3 (empty)"]="http://web/v3-empty/public/index.php"
    ["Slim 4 (empty)"]="http://web/v4-empty/public/index.php"
)


rm -f /root/siege.txt
rm -f /root/siege.log
for site in "${!sites[@]}"; do
    url=${sites[$site]}
    echo "Site: $site ($url):";

    echo "$site ($url)" &>> /root/siege.txt
    siege --log=/root/siege.log -q -t 30s -c 10 -b $url &>> /root/siege.txt
    curl -X POST -H "Content-Type: application/json" "$api_url" \
      -d "{\"label\": \"$site\", \"author\":\"$author\", \"cpu\": \"$cpu\", \"memory\": \"$memory\", \"run_id\": \"$run_id\", \"log\": \"`cat /root/siege.log | tail -n1`\"}"

done

sleep 15
cat /root/siege.txt
cat /root/siege.log
