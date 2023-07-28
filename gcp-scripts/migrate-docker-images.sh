selected=("auth" "mailer" "normal-user" "product" "search" "ads" "admin")

for service in "${selected[@]}"; do
  echo "Migrating $service"
  docker pull asia-southeast1-docker.pkg.dev/efiss-394203/efiss/"$service":latest
  docker tag asia-southeast1-docker.pkg.dev/efiss-394203/efiss/"$service":latest asia-southeast1-docker.pkg.dev/efiss-394203/efiss/"$service":latest
  #docker push asia-southeast1-docker.pkg.dev/efiss-394203/efiss/"$service":latest
done

