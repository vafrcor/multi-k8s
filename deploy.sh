docker build -t vafrcor/complex-client:latest -t vafrcor/complex-client:$SHA -f ./client/Dockerfile ./client
# docker build -t vafrcor/complex-nginx -t vafrcor/complex-nginx:$SHA -f ./nginx/Dockerfile ./nginx
docker build -t vafrcor/complex-server:latest -t vafrcor/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t vafrcor/complex-worker:latest -t vafrcor/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vafrcor/complex-client:latest
docker push vafrcor/complex-client:$SHA
# docker push vafrcor/complex-nginx:latest
# docker push vafrcor/complex-nginx:$SHA
docker push vafrcor/complex-server:latest
docker push vafrcor/complex-server:$SHA
docker push vafrcor/complex-worker:latest
docker push vafrcor/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vafrcor/complex-server:$SHA
kubectl set image deployments/client-deployment server=vafrcor/complex-client:$SHA
kubectl set image deployments/worker-deployment server=vafrcor/complex-worker:$SHA
