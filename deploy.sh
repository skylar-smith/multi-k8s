docker build -t savvyskylark/multi-client:latest -t savvyskylark/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t savvyskylark/multi-server:latest -t savvyskylark/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t savvyskylark/multi-worker:latest -t savvyskylark/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push savvyskylark/multi-client:latest
docker push savvyskylark/multi-server:latest
docker push savvyskylark/multi-worker:latest
docker push savvyskylark/multi-client:$SHA
docker push savvyskylark/multi-server:$SHA
docker push savvyskylark/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployments server=savvyskylark/multi-server:$SHA
kubectl set image deployments/client-deployments server=savvyskylark/multi-client:$SHA
kubectl set image deployments/worker-deployments server=savvyskylark/multi-worker:$SHA