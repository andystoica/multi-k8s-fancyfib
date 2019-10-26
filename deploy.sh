docker build -t andystoica/fancyfib-client -f ./client/Dockerfile ./client
docker build -t andystoica/fancyfib-api -f ./api/Dockerfile ./api
docker build -t andystoica/fancyfib-worker -f ./worker/Dockerfile ./worker

docker push andystoica/fancyfib-client
docker push andystoica/fancyfib-api
docker push andystoica/fancyfib-worker

kubectl apply -f k8s
kubectl set image deployments/api-deployment api=andystoica/fancyfib-api