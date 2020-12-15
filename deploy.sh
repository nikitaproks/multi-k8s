docker built --tag nikitaproks/multi-client:latest --tag nikitaproks/multi-client:$SHA -f ./client/Dockerfile ./client
docker built --tag nikitaproks/multi-server:latest --tag nikitaproks/multi-server:$SHA -f ./server/Dockerfile ./server
docker built --tag nikitaproks/multi-worker:latest --tag nikitaproks/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nikitaproks/multi-client:latest
docker push nikitaproks/multi-server:latest
docker push nikitaproks/multi-worker:latest

docker push nikitaproks/multi-client:$SHA
docker push nikitaproks/multi-server:$SHA
docker push nikitaproks/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nikitaproks/multi-server:$SHA
kubectl set image deployments/client-deployment client=nikitaproks/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nikitaproks/multi-worker:$SHA