docker build -t afroz4ibm/multi-client-k8s:latest -t afroz4ibm/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t afroz4ibm/multi-server-k8s-pgfix:latest -t afroz4ibm/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t afroz4ibm/multi-worker-k8s:latest -t afroz4ibm/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push afroz4ibm/multi-client-k8s:latest
docker push afroz4ibm/multi-server-k8s-pgfix:latest
docker push afroz4ibm/multi-worker-k8s:latest

docker push afroz4ibm/multi-client-k8s:$SHA
docker push afroz4ibm/multi-server-k8s-pgfix:$SHA
docker push afroz4ibm/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=afroz4ibm/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=afroz4ibm/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=afroz4ibm/multi-worker-k8s:$SHA
