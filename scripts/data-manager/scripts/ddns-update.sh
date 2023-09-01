#!/bin/bash
## change to "bin/sh" when necessary
# curl -s https://raw.githubusercontent.com/EFISS-Capstone-SU23/k8s-manifest/main/scripts/ddns-update.sh | bash -s "token"

auth_email="thaiminhpv@gmail.com"                                      # The email used to login 'https://dash.cloudflare.com'
auth_method="global"                                # Set to "global" for Global API Key or "token" for Scoped API Token 
auth_key="..."                                        # Your API Token or Global API Key
zone_identifier="6d7de9b85ff84130798be78fad2eb6ba"                                 # Can be found in the "Overview" tab of your domain
record_name="crawler.efiss.tech"                                     # Which record you want to be synced
ttl=${1:-2592000}
proxy=false                                        # Set the proxy to true or false



###########################################
## Check if we have a public IP
###########################################
ip=$(curl -s https://api.ipify.org || curl -s https://ipv4.icanhazip.com/)

echo "IP: ${ip}"

if [ "${ip}" == "" ]; then 
  logger -s "DDNS Updater: No public IP found"
  exit 1
fi

###########################################
## Check and set the proper auth header
###########################################
if [ "${auth_method}" == "global" ]; then
  auth_header="X-Auth-Key:"
else
  auth_header="Authorization: Bearer"
fi

###########################################
## Seek for the A record
###########################################

logger "DDNS Updater: Check Initiated"
record=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records?name=$record_name" -H "X-Auth-Email: $auth_email" -H "$auth_header $auth_key" -H "Content-Type: application/json")

###########################################
## Check if the domain has an A record
###########################################
if [[ $record == *"\"count\":0"* ]]; then
  logger -s "DDNS Updater: Record does not exist, perhaps create one first? (${ip} for ${record_name})"
  exit 1
fi

###########################################
## Get existing IP
###########################################
old_ip=$(echo "$record" | sed -E 's/.*"content":"(([0-9]{1,3}\.){3}[0-9]{1,3})".*/\1/')
# Compare if they're the same
if [[ $ip == $old_ip ]]; then
  logger "DDNS Updater: IP ($ip) for ${record_name} has not changed."
  exit 0
fi

###########################################
## Set the record identifier from result
###########################################
record_identifier=$(echo "$record" | sed -E 's/.*"id":"(\w+)".*/\1/')

###########################################
## Change the IP@Cloudflare using the API
###########################################
update=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records/$record_identifier" \
                     -H "X-Auth-Email: $auth_email" \
                     -H "$auth_header $auth_key" \
                     -H "Content-Type: application/json" \
              --data "{\"id\":\"$zone_identifier\",\"type\":\"A\",\"proxied\":${proxy},\"name\":\"$record_name\",\"content\":\"$ip\",\"ttl\":\"$ttl\"}")

###########################################
## Report the status
###########################################
case "$update" in
*"\"success\":false"*)
  logger -s "DDNS Updater: $ip $record_name DDNS failed for $record_identifier ($ip). DUMPING RESULTS:\n$update"
  exit 1;;
*)
  logger "DDNS Updater: $ip $record_name DDNS updated."
  exit 0;;
esac
