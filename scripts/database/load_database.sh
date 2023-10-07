#!/bin/bash

read -sp "Enter password: " password

services=("ads" "auth" "admin" "normal-user")

for service in "${services[@]}"; do
    mysql -h $service.db.efiss.tech --user=root -P 3306 -p"$password" < $service.sql
done
