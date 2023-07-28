selected=("auth" "mailer" "normal-user" "product" "search" "ads" "admin")

for service in "${selected[@]}"; do
  echo "Migrating $service"
  docker pull asia-southeast1-docker.pkg.dev/even-acumen-386115/efiss/mailer:latest
  docker tag asia-southeast1-docker.pkg.dev/even-acumen-386115/efiss/"$service":latest asia-southeast1-docker.pkg.dev/efiss-394203/efiss/"$service":latest
  #docker push asia-southeast1-docker.pkg.dev/efiss-394203/efiss/"$service":latest
done

ai_images_tags=("2.6.0-cpu" "2.5.0-cpu" "2.4.0-cpu" "2.3.0-cpu" "2.2.0-cpu" "2.1.0-cpu" "2.0.0-cpu" "latest")

for tag in "${ai_images_tags[@]}"; do
  echo "Migrating ai:$tag"
#   docker pull asia-southeast1-docker.pkg.dev/even-acumen-386115/efiss/efiss-ai:"$tag"
  docker tag asia-southeast1-docker.pkg.dev/even-acumen-386115/efiss/efiss-ai:"$tag" asia-southeast1-docker.pkg.dev/efiss-394203/efiss/ai:"$tag"
  docker push asia-southeast1-docker.pkg.dev/efiss-394203/efiss/ai:"$tag"
done