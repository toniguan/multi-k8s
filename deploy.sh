docker build -t tgdocker2019/multi-client:latest -t tgdocker2019/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tgdocker2019/multi-server:latest -t tgdocker2019/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tgdocker2019/multi-worker:latest -t tgdocker2019/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tgdocker2019/multi-client:latest
docker push tgdocker2019/multi-server:latest
docker push tgdocker2019/multi-worker:latest
docker push tgdocker2019/multi-client:$SHA
docker push tgdocker2019/multi-server:$SHA
docker push tgdocker2019/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tgdocker2019/multi-server:$SHA
kubectl set image deployments/client-deployment client=tgdocker2019/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tgdocker2019/multi-worker:$SHA
