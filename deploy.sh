docker build -t rstkhldntsk/multi-client:latest -t rstkhldntsk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rstkhldntsk/multi-server:latest -t rstkhldntsk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rstkhldntsk/multi-worker:latest -t rstkhldntsk/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rstkhldntsk/multi-client:latest
docker push rstkhldntsk/multi-server:latest
docker push rstkhldntsk/multi-worker:latest
docker push rstkhldntsk/multi-client:$SHA
docker push rstkhldntsk/multi-server:$SHA
docker push rstkhldntsk/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rstkhldntsk/multi-server:$SHA
kubectl set image deployments/client-deployment client=rstkhldntsk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rstkhldntsk/multi-worker:$SHA
