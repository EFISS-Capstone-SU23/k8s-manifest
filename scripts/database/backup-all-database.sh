#!/bin/bash

read -sp "Enter password: " password

services=("efiss_ads" "efiss_auth" "efiss_admin" "efiss_normal_user")

for service in "${services[@]}"; do
    mysqldump -h mysql.efiss.tech --user=root -P 3306 -p"$password" --single-transaction=TRUE --set-gtid-purged=OFF --databases $service > $service.sql 
done

# mysql -h mysql.efiss.tech --user=root -P 3306 -p"$password" < $service.sql
