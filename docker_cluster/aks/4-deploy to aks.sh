clear
kubectl apply -f namespace.yml

clear
kubectl apply -f pvc.yml
kubectl get pvc -n production

clear
kubectl get sc

clear
kubectl apply -f sql-statefulset.yml
kubectl apply -f webapp.yml
kubectl get services -n production
kubectl get pods -n production