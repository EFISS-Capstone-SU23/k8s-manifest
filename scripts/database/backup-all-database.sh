#!/bin/bash

read -sp "Enter password: " password

services=("ads" "auth" "admin")

for service in "${services[@]}"; do
    mysqldump -h $service.db.efiss.tech --user=root -P 3306 -p"$password" --single-transaction=TRUE --set-gtid-purged=OFF --databases efiss_$service > $service.sql 
    # mysql -h $service.db.efiss.tech --user=root -P 3306 -p"$password" < $service.sql
done

service="normal-user"
mysqldump -h $service.db.efiss.tech --user=root -P 3306 -p"$password" --single-transaction=TRUE --set-gtid-purged=OFF --databases efiss_normal_user > $service.sql 
