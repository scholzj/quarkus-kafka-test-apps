# Deploy

```bash
kubectl create ns my-kafka-project
kubectl -n my-kafka-project apply -f deployment/kafka/common/cluster.yaml
kubectl -n my-kafka-project apply -f deployment/kafka/common/topic.yaml
```

# Clean up

```bash
kubectl delete -n my-kafka-project kafkatopic/kafka-test-apps
kubectl -n my-kafka-project delete kafka/my-cluster
kubectl delete ns my-kafka-project
```