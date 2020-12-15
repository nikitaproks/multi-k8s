docker built -t nikitaproks/multi-client:latest  -f ./client/Dockerfile ./client
docker built -t nikitaproks/multi-server:latest   -f ./server/Dockerfile ./server
docker built -t nikitaproks/multi-worker:latest   -f ./worker/Dockerfile ./worker

#docker tag nikitaproks/multi-client:latest nikitaproks/multi-client:$SHA 
#docker tag nikitaproks/multi-server:latest nikitaproks/multi-server:$SHA 
#docker tag nikitaproks/multi-worker:latest nikitaproks/multi-worker:$SHA

#docker push nikitaproks/multi-client:latest
#docker push nikitaproks/multi-server:latest
#docker push nikitaproks/multi-worker:latest

docker push nikitaproks/multi-client:latest 
docker push nikitaproks/multi-server:latest 
docker push nikitaproks/multi-worker:latest 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nikitaproks/multi-server:latest 
kubectl set image deployments/client-deployment client=nikitaproks/multi-client:latest 
kubectl set image deployments/worker-deployment worker=nikitaproks/multi-worker:latest 