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
	@echo "#  upgrade-airports update airport to 1.1.0 "
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

upgrade-airports:
	bash -c "kubectl set image deployment airport-api-server-deployment airport-api-server=shahabshahab2/airport-apiserver:1.1.0 -n lunatech"

clean:
	bash -c "minikube stop && minikube delete"

deploy:
	bash -c "kubectl apply -f deployments/0-namespace.yaml"
	bash -c	"kubectl apply -f deployments/kube-addons/"
	bash -c	"kubectl apply -f deployments/airports/"
	bash -c	"kubectl apply -f deployments/countries/"
	bash -c	"kubectl apply -f deployments/jenkins/"
@echo "Access this services by using this url:"
	bash -c "minikube service  --url -n lunatech"

