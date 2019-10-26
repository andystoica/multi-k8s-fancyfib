# Build latest production images
docker build \
  -t andystoica/fancyfib-api:latest \
  -t andystoica/fancyfib-api:$SHA \
  -f ./api/Dockerfile ./api

docker build \
  -t andystoica/fancyfib-client:latest \
  -t andystoica/fancyfib-client:$SHA \
  -f ./client/Dockerfile ./client

docker build \
  -t andystoica/fancyfib-worker:latest \
  -t andystoica/fancyfib-worker:$SHA \
  -f ./worker/Dockerfile ./worker

# Push images to DockerHub
docker push andystoica/fancyfib-api:latest
docker push andystoica/fancyfib-api:$SHA

docker push andystoica/fancyfib-client:latest
docker push andystoica/fancyfib-client:$SHA

docker push andystoica/fancyfib-worker:latest
docker push andystoica/fancyfib-worker:$SHA

# Update Deployments to use the new images
kubectl apply -f k8s
kubectl set image deployments/api-deployment api=andystoica/fancyfib-api:$SHA
kubectl set image deployments/client-deployment client=andystoica/fancyfib-client:$SHA
kubectl set image deployments/worker-deployment worker=andystoica/fancyfib-worker:$SHA