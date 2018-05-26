#!/bin/bash

IP=$(curl -s "https://ipinfo.io/ip")
echo "THIS IS IP $IP"

curlUpdate(){
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$1/dns_records/$2" \
-H "X-Auth-Email: johndoe@example.com" -H "X-Auth-Key: YOUR_CLOUDFLARE_API_KEY" \
-H "Content-Type: application/json" \
--data "{\"type\":\"A\",\"name\":\"$4\",\"content\":\"$3\",\"proxied\":true}"
}

curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "johnpili.com"
curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "www.johnpili.com"
#curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "domain1.com"
#curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "www.domain1.com"
#curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "domain2.com"
#curlUpdate "ZONE_ID" "ID_OF_DNS_RECORD" "$IP" "www.domain2.com"
