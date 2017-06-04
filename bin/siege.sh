#!/bin/bash


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
for site in "${!sites[@]}"; do
    url=${sites[$site]}
    echo "Site: $site ($url):";

    echo "$site ($url)" &>> /root/siege.txt
    siege --log=/root/siege.log -q -t 30s -c 10 -b $url &>> /root/siege.txt

done

sleep 8
cat /root/siege.txt


# siege -V
# curl -s http://web/v3-empty/public/index.php
