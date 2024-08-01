
set -x
echo "starting benchmarks..."
kubectl delete -f k8s/warp-get.yaml;  kubectl apply -f k8s/warp-get.yaml
sleep 1500 
kubectl delete -f k8s/warp-put.yaml; kubectl apply -f k8s/warp-put.yaml
sleep 1500 
kubectl delete -f k8s/warp-get-ranged.yaml; kubectl apply -f k8s/warp-get-ranged.yaml
sleep 1500
echo "finished benchmarks..."