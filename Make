SHELL := /bin/bash

.PHONY: help

help:
@echo "============================================"
@echo "# 	HELP make <target>	                  #"
@echo "============================================"
@echo "#  airports       Exec airports app   	   "
@echo "#  countries      Exec countries app  	   "
@echo "#  jenkins        Exec Jenkins CI/CD app    "
@echo "#  clean          Remove local containers   "
@echo "#  deploy         All K8s OBJECT CREATION   "
@echo "============================================"

airports:
bash -c "kubectl apply -f deployments/0-namespace.yaml"
bash -c "kubectl apply -f deployments/airports"
@echo "Access this service by using this url:"
bash -c "minikube service airport-api-server-exposeservice --url"

countries:
bash -c "kubectl apply -f deployments/0-namespace.yaml"
bash -c "kubectl apply -f deployments/countries"
@echo "Access this service by using this url:"
bash -c "minikube service countries-api-server-exposeservice --url"

jenkins:
bash -c "kubectl apply -f deployments/0-namespace.yaml"
bash -c "kubectl apply -f deployments/jenkins"
@echo "Access this service by using this url:"
bash -c "minikube service jenkins-server-exposeservice --url"

clean:
bash -c "minikube stop && minikube delete"

deploy:
bash -c "kubectl apply -f deployments/0-namespace.yaml"
bash -c "kubectl apply -f deployments/"
@echo "Access this services by using this url:"
bash -c "minikube service  --url -n lunatech"

