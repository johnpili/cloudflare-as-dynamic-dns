#!/bin/bash

IP=$(curl -s "https://ipinfo.io/ip")
echo "THIS IS IP $IP"
touch dynip.txt
OLD_IP=$(cat dynip.txt)
echo "OLD IP: $OLD_IP"

curlUpdate(){
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$1/dns_records/$2" \
-H "X-Auth-Email: johndoe@example.com" -H "X-Auth-Key: YOUR_CLOUDFLARE_API_KEY" \
-H "Content-Type: application/json" \
--data "{\"type\":\"A\",\"name\":\"$4\",\"content\":\"$3\",\"proxied\":$5}"
}

if [ "$IP" != "$OLD_IP" ]; then
    echo "Changing IP"
    echo $IP > dynip.txt
    curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "johnpili.com" "true"
    curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "www.johnpili.com" "true"
    curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "ssh.johnpili.com" "false"
    #curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "domain1.com" "true"
    #curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "www.domain1.com" "true"
    #curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "domain2.com" "true"
    #curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "www.domain2.com" "true"
fi
