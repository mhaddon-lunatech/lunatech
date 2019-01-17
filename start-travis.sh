#!/bin/bash
echo "Deploying services"
kubectl apply -f deployments/0-namespace.yaml
kubectl apply -f deployments/
kubectl rollout status deployment -n lunatech
IP=$(minikube ip)
echo "You can check your services at $IP"