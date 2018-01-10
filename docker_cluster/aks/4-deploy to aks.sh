kubectl apply -f namespace.yml

kubectl apply -f pvc.yml

kubectl get pvc -n production

kubectl get sc

kubectl apply -f sql-statefulset.yml

kubectl apply -f webapp.yml

kubectl get services -n production

kubectl apply -f mssql-cli.yml

kubectl get pods -n production