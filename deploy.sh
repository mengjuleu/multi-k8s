docker build -t mleu/multi-client:latest -t mleu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mleu/multi-server:latest -t mleu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mleu/multi-worker:latest -t mleu/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mleu/multi-client:latest
docker push mleu/multi-client:$SHA
docker push mleu/multi-server:latest
docker push mleu/multi-server:$SHA
docker push mleu/multi-worker:latest
docker push mleu/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mleu/multi-server:$SHA
kubectl set image deployments/client-deployment client=mleu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mleu/multi-worker:$SHA