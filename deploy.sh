docker built -t nikitaproks/multi-client:latest -t nikitaproks/multi-client:$SHA -f ./client/Dockerfile ./client
docker built -t nikitaproks/multi-server:latest -t nikitaproks/multi-server:$SHA -f ./server/Dockerfile ./server
docker built -t nikitaproks/multi-worker:latest -t nikitaproks/multi-worker:$SHA -f ./worker/Dockerfile ./worker

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